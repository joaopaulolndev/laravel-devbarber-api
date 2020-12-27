<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BarberReview extends Model
{
    protected $fillable = ['barber_id','rate'];

    public function barber()
    {
        return $this->belongsTo(Barber::class);
    }
}
