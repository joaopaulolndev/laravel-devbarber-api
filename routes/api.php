<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::group(['prefix' => 'v1', 'namespace' => 'Api\v1'], function () {
    Route::post('auth/login', 'Auth\AuthController@login');
    Route::post('auth/register', 'Auth\AuthController@register');
});

/*
 * Routes private
 */
Route::group(['prefix' => 'v1', 'namespace' => 'Api\v1', 'middleware' => ['auth:api']], function () {
    Route::get('auth/me', 'Auth\AuthController@me');
    Route::post('auth/updateProfile', 'Auth\AuthController@updateProfile');
    Route::get('auth/logout', 'Auth\AuthController@logout');

    Route::get('/users/favorites', 'UserController@getFavorites');
    Route::post('/users/favorite', 'UserController@addFavorites');
    Route::get('/users/appointments', 'UserController@getAppointment');

    Route::get('/barbers', 'BarberController@index');
    Route::get('/barbers/{id}', 'BarberController@show');
    Route::post('/barbers/{id}/appointment', 'BarberController@addAppoitment');

    Route::get('/search', 'BarberController@search');
});

