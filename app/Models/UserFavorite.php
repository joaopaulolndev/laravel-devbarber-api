<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserFavorite extends Model
{
    protected $fillable = ['user_id'];

    public function barber()
    {
        return $this->belongsTo(Barber::class, 'barber_id', 'id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }

    public function barberFavorited($id)
    {
        return $this->where('barber_id', $id)
            ->where('user_id', auth()->user()->id)
            ->count() > 0 ? true : false;
    }
}
