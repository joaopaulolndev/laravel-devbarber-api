<?php

namespace App\Http\Controllers\Api\v1\Auth;

use App\Models\User;
use Illuminate\Support\Facades\Hash;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Intervention\Image\Facades\Image;

class AuthController extends Controller
{
    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     * @throws \Illuminate\Validation\ValidationException
     */
    public function login(Request $request)
    {
        try {
            $this->validate($request, [
                'email' => ['required','string','email'],
                'password' => ['required','string'],
            ]);

            $data = $request->only('email','password');

            $user = User::where('email', $data['email'])->first();

            if (!$user) {
                return response()->json(["error" => true, "message" => "Usuário não encontrado com este e-mail"]);
            }

            if (Hash::check($data['password'], $user->password)) {
                $token = $user->createToken('Acesso Passport token no login')->accessToken;
                return response()->json([
                    'error' => false,
                    'user' => $user,
                    'access_token' => $token
                ]);
            } else {
                return response()->json(["error" => true, "message" => "Credenciais inválidas, favor verifique"]);
            }
        } catch (\Exception $exception) {
            return response()->json(["error" => true, "message" => $exception->getMessage()], 400);
        }
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     * @throws \Illuminate\Validation\ValidationException
     */
    public function register(Request $request)
    {
        try {
            $this->validate($request, [
                'name' => ['required','string','min:5','max:255'],
                'email' => ['required','string','email','unique:users'],
                'password' => ['required','string','min:6','confirmed'],
            ]);

            $data = $request->only('name','email','password');

            $user = new User();
            $user->name = $data['name'];
            $user->email = $data['email'];
            $user->password = $data['password'];
            $user->save();

            $token = $user->createToken('Acesso Passport token no cadastro')->accessToken;

            // $request = Request::create('oauth/token', 'POST', [
            //     'grant_type' => 'password',
            //     'client_id' => '2',
            //     'client_secret' => '3XhQ9q6ls1RpZWkM69XpShsMGVBejbIPrC7waWVH',
            //     'username' => $data['email'],
            //     'password' => $data['password'],
            // ]);

            // $response = app()->handle($request);

            //return response()->json(json_decode($response->getContent()));
            return response()->json([
                'error' => false,
                'user' => $user,
                'access_token' => $token
            ]);
        } catch (\Exception $exception) {
            return response()->json(["error" => true, "message" => $exception->getMessage()], 400);
        }
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     * @throws \Illuminate\Validation\ValidationException
     */
    public function updateProfile(Request $request)
    {
        $user = User::where('id', $request->user()->id)->first();

        if (!$user) {
            return response()->json([
                'error' => true,
                'message' => 'Opss. Usuário não foi encontrado, favor verifique se esta logado.'
            ]);
        }

        $this->validate($request, [
            'name' => ['required','string','min:5','max:255'],
            'email' => ['required','string','email','unique:users,email,'.$user->id],
        ]);

        if (isset($request->password) && !is_null($request->password)) {
            $this->validate($request, [
                'password' => ['required','string','min:6','confirmed'],
            ]);
        }

        $oldAvatar = $user->avatar;

        $data = $this->uploadData($request);

        $user->update($data);

        if ($oldAvatar !== $user->avatar) {
            $this->removeImage($oldAvatar);
        }

        return response()->json([
            'error' => false,
            'data' => $user
        ]);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function me(Request $request)
    {
        $user = User::where('id', $request->user()->id)->first();

        if (!$user) {
            return response()->json([
                'error' => true,
                'message' => 'Opss. Usuário não foi encontrado, favor verifique se esta logado.'
            ]);
        }

        return response()->json($user);
    }

    /**
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout()
    {
        if (Auth::check()) {
            Auth::user()->oauthAccessToken()->delete();
        }

        return response()->json(['status' => 'success']);
    }

    private function uploadData($request)
    {
        $data = $request->all();
        $extensions = ['jpeg','jpg','png'];

        if ($request->hasFile('avatar')) {
            $avatar = $request->file('avatar');
            $filename = time() . "-" . $avatar->getClientOriginalName();
            $extension = $avatar->getClientOriginalExtension();
            if (in_array($extension, $extensions)) {
                Image::make($avatar->path())
                ->fit(200, 200)
                ->save(public_path("uploads/avatars/") . $filename);
                $data["avatar"] = $filename;
            }
        }

        return $data;
    }

    private function removeImage($image)
    {
        if (!empty($image))
        {
            $imagePath = public_path("uploads/avatars/") . '/' . $image;

            if (file_exists($imagePath)) 
            {
                unlink($imagePath);
            }
        }
    }
}