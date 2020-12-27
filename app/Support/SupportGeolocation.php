<?php

namespace App\Support;

class SupportGeolocation
{
    private static $url = "https://maps.googleapis.com/maps/api/geocode/json";

    public static function search($address)
    {
        $address = urlencode($address);
        $url = self::$url . "?address={$address}&key=".config('app.maps_key');
        return SupportCurl::curl_get($url);
    }
}