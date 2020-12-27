<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserAppointment extends Model
{
    protected $fillable = ['user_id','barber_service_id','appointment_datetime'];

    public function barber()
    {
        return $this->belongsTo(Barber::class, 'barber_id', 'id');
    }

    public function service()
    {
        return $this->belongsTo(BarberService::class, 'barber_service_id', 'id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }
}
