<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('programs', function (Blueprint $table) {
            $table->string('prog_id')->unique()->primary();
            $table->string('prog_name');
            $table->integer('capacity')->default(600);
            $table->integer('nta_level');
            $table->string('department');
            $table->foreign('department')->references('dept_code')->on('departments')->onUpdate('cascade')->onDelete(null);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('programs');
    }
};
