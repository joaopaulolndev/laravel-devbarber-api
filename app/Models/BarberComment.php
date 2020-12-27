<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BarberComment extends Model
{
    protected $fillable = ['barber_id','name','rate','body'];

    public function barber()
    {
        return $this->belongsTo(Barber::class);
    }
}
