<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */
$factory->define(App\Models\User::class, function (Faker\Generator $faker) {
    static $password;

    return [
        'name' => $faker->name,
        'email' => $faker->unique()->safeEmail,
        'password' => $password ?: $password = bcrypt('secret'),
        'remember_token' => str_random(10),
    ];
});

/** @var \Illuminate\Database\Eloquent\Factory $factory */
$factory->define(App\Models\Barber::class, function (Faker\Generator $faker) {
    return [
        'name' => $faker->name,
        'avatar' => rand(1, 4).'.png',
        'starts' => rand(2, 4).'.'.rand(0,9),
        'latitude' => '-23.5'.rand(0,9).'30907',
        'longitude' => '-46.6'.rand(0,9).'82795',
    ];
});

/** @var \Illuminate\Database\Eloquent\Factory $factory */
$factory->define(App\Models\BarberService::class, function (Faker\Generator $faker) {
    return [
        'barber_id' => rand(1,5),
        'name' => $faker->name,
        'price' => $faker->numberBetween($min = 10, $max = 100),
    ];
});

/** @var \Illuminate\Database\Eloquent\Factory $factory */
$factory->define(App\Models\BarberPhoto::class, function (Faker\Generator $faker) {
    return [
        'barber_id' => rand(1,5),
        'url' => rand(1, 4).'.png',
    ];
});

/** @var \Illuminate\Database\Eloquent\Factory $factory */
$factory->define(App\Models\BarberReview::class, function (Faker\Generator $faker) {
    return [
        'barber_id' => rand(1,5),
        'rate' => rand(2, 4).'.'.rand(0,9),
    ];
});

/** @var \Illuminate\Database\Eloquent\Factory $factory */
$factory->define(App\Models\BarberComment::class, function (Faker\Generator $faker) {
    return [
        'barber_id' => rand(1,5),
        'name' => $faker->name,
        'rate' => rand(2, 4).'.'.rand(0,9),
        'body' => $faker->text,
    ];
});

/** @var \Illuminate\Database\Eloquent\Factory $factory */
$factory->define(App\Models\BarberAvailability::class, function (Faker\Generator $faker) {

    static $hours = array();

    for($e=0;$e<4;$e++){
        $rAdd = rand(7, 10);
        $hours = [];
        for($r=0;$r<8;$r++) {
            $time = $r + $rAdd;
            if($time < 10) {
                $time = '0'.$time;
            }
            $hours[] = $time.':00';
        }
    }

    return [
        'barber_id' => rand(1,5),
        'weekday' => rand(0, 4),
        'hours' => implode(',', $hours),
    ];
});
