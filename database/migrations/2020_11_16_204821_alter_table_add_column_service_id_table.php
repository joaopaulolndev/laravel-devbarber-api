<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterTableAddColumnServiceIdTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('user_appointments', function (Blueprint $table) {
            $table->integer('barber_service_id')->unsigned()->after('barber_id');
            $table->foreign('barber_service_id')->references('id')->on('barber_services')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('user_appointments', function (Blueprint $table) {
            $table->dropColumn('barber_service_id');
        });
    }
}
