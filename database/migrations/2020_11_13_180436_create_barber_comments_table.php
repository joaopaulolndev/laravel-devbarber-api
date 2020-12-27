<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateBarberCommentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('barber_comments', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('barber_id')->unsigned();
            $table->foreign('barber_id')->references('id')->on('barbers')->onDelete('cascade');
            $table->string('name');
            $table->float('rate')->default(0);
            $table->text('body');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('barber_comments');
    }
}
