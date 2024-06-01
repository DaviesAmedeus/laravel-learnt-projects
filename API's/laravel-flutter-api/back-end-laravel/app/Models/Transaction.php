<?php

namespace App\Models;

use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Transaction extends Model
{
    use HasFactory;

    protected $fillable = ['category_id', 'transaction_date', 'amount', 'description', 'user_id'];
    protected $dates = ['transaction_date'];

    public function category(){
        return $this->belongsTo(Category::class);
    }


    protected static function booted(): void
    {
        if(Auth::check()){
            static::addGlobalScope('by_user', function (Builder $builder) {
                $builder->where('user_id', Auth::user()->id);
            });
        }
    }
}
