<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BarberService extends Model
{
    protected $fillable = ['barber_id','name','price'];

    public function barber()
    {
        return $this->belongsTo(Barber::class);
    }
}
