<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function register(Request $request) {
        $request->validate([
            'name' => 'required|string',
            'email' => 'required|string|email|unique:users',
            'password' => 'required|string|min:6',
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        return response()->json($user, 201);
    }

    public function login(Request $request) {
        $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        return response()->json(['token' => $user->createToken('token_name')->plainTextToken]);
    }

    public function getUser(Request $request) {
        return response()->json($request->user());
    }

    public function updateUser(Request $request) {
        $request->validate([
            'name' => 'string',
            'email' => 'string|email',
        ]);

        $user = $request->user();
        $user->update($request->only('name', 'email'));

        return response()->json($user);
    }

    public function deleteUser(Request $request) {
        $user = $request->user();
        $user->delete();

        return response()->json(['message' => 'User deleted']);
    }
}