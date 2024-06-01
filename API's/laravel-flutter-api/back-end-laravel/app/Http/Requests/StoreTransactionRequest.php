<?php

namespace App\Http\Requests;

use Illuminate\Validation\Rule;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class StoreTransactionRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
              'category_id'=> ['required', Rule::exists('categories', 'id')->where('user_id', Auth::user()->id)],
              'amount'=> 'required',
              'description'=> 'required',
              'transaction_date'=> 'required|date',
        ];
    }
}

http://127.0.0.1:8000/api/transactions


