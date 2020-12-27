<?php

namespace App\Models;

use Laravel\Passport\HasApiTokens;
use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable
{
    use HasApiTokens, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'password', 'avatar'
    ];

    /**
     * @var array
     */
    protected $appends = ['avatar_url'];


    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    /**
     * @param $value
     */
    public function setPasswordAttribute($value)
    {
        if (!is_null($value)) {
            $this->attributes['password'] = app("hash")->make($value);
        }
    }

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

    /**
     * User has many .
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function oauthAccessToken()
    {
        return $this->hasMany('\App\Models\OauthAccessToken');
    }

    public function appointments()
    {
        return $this->hasMany(UserAppointment::class);
    }

    public function favorites()
    {
        return $this->hasMany(UserFavorite::class);
    }
}
