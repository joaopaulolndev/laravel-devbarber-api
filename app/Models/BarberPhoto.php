<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BarberPhoto extends Model
{
    protected $fillable = ['barber_id','url'];

    /**
     * @var array
     */
    protected $appends = ['image_url'];

    public function barber()
    {
        return $this->belongsTo(Barber::class);
    }

    /**
     * @return string|null
     */
    public function getImageUrlAttribute()
    {
        if ($this->url) {
            return url('uploads/photos') . '/' . $this->url;
        }

        return url('uploads/photos') . '/default.png';
    }
}
