<?php

use App\Http\Controllers\AuthControlller;
use App\Http\Controllers\ProductController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

// Public routes
// Route::resource('products', ProductController::class);
Route::post('/register', [AuthControlller::class, 'register']);
Route::post('/login', [AuthControlller::class, 'login']);

Route::get('/products', [ProductController::class, 'index']);
Route::get('/products/{id}', [ProductController::class, 'show']);
Route::get('/products/search/{name}', [ProductController::class, 'search']);


// Protected routes
Route::group(['middleware'=>['auth:sanctum']], function () {
    Route::post('/products', [ProductController::class, 'store']);
    Route::put('/products/{id}', [ProductController::class, 'update']);
    Route::delete('/products/{id}', [ProductController::class, 'destroy']);
    Route::post('/logout', [AuthControlller::class, 'logout']);


});

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

