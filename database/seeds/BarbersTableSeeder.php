<?php

use Illuminate\Database\Seeder;

class BarbersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //factory(\App\Models\User::class, 5)->create();
        factory(\App\Models\Barber::class, 5)->create();
        factory(\App\Models\BarberService::class, 5)->create();
        factory(\App\Models\BarberPhoto::class, 5)->create();
        factory(\App\Models\BarberReview::class, 5)->create();
        factory(\App\Models\BarberComment::class, 5)->create();
        factory(\App\Models\BarberAvailability::class, 5)->create();
    }
}
