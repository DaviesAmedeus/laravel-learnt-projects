<?php

namespace App\Http\Controllers\Api;

use App\Models\Student;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class AuthController extends Controller
{
    public function login(Request $request){
        
        $request->validate([
       
            'user_name' => 'required',
            'password' => 'required',
           
        ]);
     
        $student = Student::where('student_id', $request->user_name)->first();
     
        if (! $student || $request->password != $student->password) {
            return  'Credentials provided not correct';
        }

        return $student;
    }
}
