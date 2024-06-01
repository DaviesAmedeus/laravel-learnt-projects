<?php

namespace App\Models;

use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Category extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'user_id'];

     
    protected static function booted(): void
    {
        if(Auth::check()){
            static::addGlobalScope('by_user', function (Builder $builder) {
                $builder->where('user_id', Auth::user()->id);
            });
        }
    }
}
 