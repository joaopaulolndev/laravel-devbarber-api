<?php

namespace App\Models;

use App\Support\SupportGeolocation;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Barber extends Model
{
    protected $fillable = ['name','avatar','starts','latitude','longitude'];

    /**
     * @var array
     */
    protected $appends = ['avatar_url'];

    /**
     * @return string|null
     */
    public function getAvatarUrlAttribute()
    {
        if ($this->avatar) {
            return url('uploads/avatars') . '/' . $this->avatar;
        }

        return url('uploads/avatars') . '/default.png';
    }

    public function services()
    {
        return $this->hasMany(BarberService::class);
    }

    public function photos()
    {
        return $this->hasMany(BarberPhoto::class);
    }

    public function comments()
    {
        return $this->hasMany(BarberComment::class);
    }

    public function availabilities()
    {
        return $this->hasMany(BarberAvailability::class);
    }

    public function appointments()
    {
        return $this->hasMany(UserAppointment::class);
    }

    public function favoriteds()
    {
        return $this->hasMany(UserFavorite::class);
    }

    public function scopeGeolocation($query, $filters = [])
    {
        $response = null;
        $latitude = '-23.5630907';
        $longitude = '-46.6682795';
        $city = 'São Paulo';
        $distance = $filters['distance'] ?? 10;

        if (isset($filters['city'])) {
            $response = SupportGeolocation::search($filters['city']);
        } else if (isset($filters['latitude']) && isset($filters['longitude'])) {
            $response = SupportGeolocation::search($filters['latitude'].','.$filters['longitude']);
        }

        if ($response['status'] === 'OK') {
            $result = array_pop($response['results']);
            $latitude = $result['geometry']['location']['lat'];
            $longitude = $result['geometry']['location']['lng'];
            $city = $result['formatted_address'];
        }

        return $query
            ->select(DB::raw("*, concat('".$city."') as loc, SQRT(
                POW(69.1 * (latitude - {$latitude}), 2) + 
                POW(69.1 * ({$longitude} - longitude) * COS(latitude / 57.3), 2)) AS distance"))
            ->havingRaw('distance < ?', [$distance])
            ->orderBy('distance', 'ASC');
    }

    public function getHours($availabilities, $userappointments)
    {
        $availability = [];
        $availsWeekDays = [];
        foreach ($availabilities as $item) {
            $availsWeekDays[$item['weekday']] = explode(',', $item['hours']);
        }

        $appointments = [];
        foreach($userappointments as $item) {
            $appointments[] = $item['appointment_datetime'];
        }

        for ($i = 0; $i < 20; $i++) {
            $timeItem = strtotime('+'.$i.' days');
            $weekday = date('w', $timeItem);

            if (in_array($weekday, array_keys($availsWeekDays))) {
                $hours = [];

                $dayItem = date('Y-m-d', $timeItem);
                foreach ($availsWeekDays[$weekday] as $hourItem) {
                    $dayFormat = $dayItem . ' ' . $hourItem.':00';

                    if (!in_array($dayFormat, $appointments)) {
                        $hours[] = $hourItem;
                    }
                }

                if (count($hours) > 0) {
                    $availability[] = [
                        'date' => $dayItem,
                        'hours' => $hours
                    ];
                }
            }
        }

        return $availability;
    }

    public function toggleFavorite($user_id)
    {
        $message = 'Babeiro adicionado aos favoritos com sucesso';

        if (!$this->favoriteds()->where('user_id', $user_id)->count()) {
            $this->favoriteds()->create([
                'user_id' => $user_id
            ]);
        } else {
            $favorite = $this->favoriteds()->where('user_id', $user_id)->first();
            $favorite->delete();
            $message = 'Babeiro removido dos favoritos com sucesso';
        }

        return $message;
    }

    public function scopeFilter($query, $filter = [])
    {
        return $query->where(function($q) use ($filter){
            if (isset($filter['q'])) {
                $q->where(function($sq) use ($filter) {
                    $sq->orWhere('name', 'LIKE', "%{$filter['q']}%");
                });
            }
        });
    }

}
