<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BarberAvailability extends Model
{
    protected $fillable = ['barber_id','weekday','hours'];

    protected $appends = ['hours_array'];

    public function barber()
    {
        return $this->belongsTo(Barber::class);
    }

    public function getHoursArrayAttribute()
    {
        return [$this->weekday] = explode(',', $this->hours);
    }
}
