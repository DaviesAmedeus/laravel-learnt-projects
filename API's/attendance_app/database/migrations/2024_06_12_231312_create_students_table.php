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
        Schema::create('students', function (Blueprint $table) {
            $table->string('student_id')->unique()->primary();
            $table->string('full_name');
            $table->string('password')->default('87654321');
            $table->string('program');
            $table->string('active')->enum('yes', 'no')->default('yes');
            $table->string('status')->default('continuing');
            $table->foreign('program')->references('prog_id')->on('programs')->onUpdate('cascade')->onDelete(null);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('students');
    }
};
