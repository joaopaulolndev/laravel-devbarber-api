<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;


use App\Models\User;
use App\Models\UserAppointment;
use App\Models\UserFavorite;
use App\Models\Barber;
use App\Models\BarberPhotos;
use App\Models\BarberServices;
use App\Models\BarberTestimonial;
use App\Models\BarberAvailabillity;

class BarbersController extends Controller
{

    private $loggedUser;

    public function __contruct(){
        $this->middleware('auth:api');
        $this->loggedUser = auth()->user();
    }

    public function createRandom() {
        $array = ['error' => ''];

        for($q=0;$q<15;$q++) {
            $names = ['Bonieky', 'Matheus', 'Lucas', 'Pedro', 'Daniel', 'Amanda', 'Leticia', 'Gabriel', 'Marcos'];
            $lastnames = ['Pereira', 'Silva', 'Lacerda', 'Diniz', 'Alvaro', 'Sousa', 'Oliveira', 'Dantes'];

            $servicos = ['Corte', 'Pintura', 'Aparação', 'Enfeite'];
            $servicos2 = ['Cabelo', 'Unha', 'Sobrancelhas', 'Fios'];

            $depos = [
                'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years',
                'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humou',
                'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',
                'The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested.',
                'All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary'
            ];

            $newBarber = new Barber();
            $newBarber->name = $names[rand(0, count($names)-1)].' '.$lastnames[rand(0, count($lastnames)-1)];
            $newBarber->avatar = rand(1, 4).'.png';
            $newBarber->stars = rand(2, 4).'.'.rand(0,9);
            $newBarber->latitude = '-23.5'.rand(0,9).'30907';
            $newBarber->longitude = '-46.6'.rand(0, 9).'82795';
            $newBarber->save();

            $ns = rand(3, 6);

            for($w=0;$w<4;$w++) {
                $newBarberPhoto = new BarberPhotos();
                $newBarberPhoto->id_barber = $newBarber->id;
                $newBarberPhoto->url = rand(1, 5).'.png';
                $newBarberPhoto->save();
            }

            for($w=0;$w<$ns;$w++) {
                $newBarberService = new BarberServices();
                $newBarberService->id_barber = $newBarber->id;
                $newBarberService->name = $servicos[rand(0, count($servicos)-1)].' de '.$servicos2[rand(0, count($servicos2)-1)];
                $newBarberService->price = rand(1, 99).'.'.rand(0, 100);
                $newBarberService->save();
            }

            for($w=0;$w<3;$w++) {
                $newBarberTestimonial = new BarberTestimonial();
                $newBarberTestimonial->id_barber = $newBarber->id;
                $newBarberTestimonial->name = $names[rand(0, count($names)-1)];
                $newBarberTestimonial->rate = rand(2, 4).'.'.rand(0, 9);
                $newBarberTestimonial->body = $depos[rand(0, count($depos)-1)];
                $newBarberTestimonial->save();
            }

            for($e=0;$e<4;$e++) {
                $rAdd = rand(7, 10);
                $hours = [];
                for($r=0;$r<8;$r++) {
                    $time = $r + $rAdd;
                    if($time < 10) {
                        $time = '0'.$time;
                    }
                    $hours[] = $time.':00';
                }
                $newBarberAvail = new BarberAvailabillity();
                $newBarberAvail->id_barber = $newBarber->id;
                $newBarberAvail->weekday = $e;
                $newBarberAvail->hours = implode(',', $hours);
                $newBarberAvail->save();
            }
        }

        return $array;
    }

    private function searcGeo($address){
        $key = env('MAPS_KEY',null);

        $address = urlencode($address);

        $url = 'https://maps.googleapis.com/maps/api/geocode/json?andress='.$address.'&key='.$key;

        $ch = curl_init();
        curl_setopt($ch , CURLOPT_URL, $url);
        curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
        $res = curl_exec($ch);
        return json_decode($res , true);
    }

    public function list(Request $request){
        $array = ['error' => ''];
        $lat   = $request->input('lat');
        $lng   = $request->input('lng');
        $city  = $request->input('city');
        $offset  = $request->input('offset');
        if(!$offset){
            $offset =0;
        }

        if(!empty($city)){
            $res = $this->searchGeo($city);
            if(count($res['results']) > 0){
                $lat = $res['results'][0]['geometry']['location']['lat'];
                $lng = $res['results'][0]['geometry']['location']['lng'];
            }

        } elseif(!empty($lat) && !empty($lng)){
            $res = $this->searcGeo($lat.','.$lng);
            if(count($res['results']) > 0){
                $city = $res['results'][0]['formatted_address'];
            }
        }else{
            $lat ='-23.5630907';
            $lng = '-46.6682795';
            $city = 'São Paulo';
        }


        $barbers = Barber::select(Barber::raw('*, SQRT(
            POW(69.1 * (latitude - '.$lat.'), 2)+
            POW(69.1 * ('.$lng.' - longitude) * COS(latitude / 57.3), 2)) AS distance'))
            ->havingRaw('distance < ?',[10])
            ->orderBy('distance','ASC')
            ->offset($offset)
            ->limit(5)
            ->get();
        foreach($barbers as $bkey => $bvalue ){
            $barbers[$bkey]['avatar'] = url('media/avatars/'.$barbers[$bkey]['avatar']);
        }
        $array['data'] = $barbers;
        $array['loc'] = 'São Paulo';

        return $array;
    }

    public function one($id){
        $array = ['error'=> ''];

        $barber = Barber::find($id);

        if($barber){
            $barber['avatar'] = url('media/avatars/'.$barber['avatar']);
            $barber['favorited'] = false ;
            $barber['photos']= [];
            $barber['services']= [];
            $barber['testimonials']= [];
            $barber['available']= [];

            //pegando os favoritos
            $cFavorite = UserFavorite::where('id_user',$this->loggedUser->id)
                ->where('id_barber', $barber->id)
                ->count();

            if($cFavorite > 0){
                $barber['favorited'] = true;
            }

            //pegando as fotos
            $barber['photos'] = BarberPhotos::select(['id','url'])
                ->where('id_barber', $barber->id)
                ->get();

            foreach($barber['photos'] as $bpkey => $bpvalue){
                $barber['photos'][$bpkey]['url'] = url('media/upload/s'.$barber['photos'][$bpkey]['url']);
            }

            //pegando os serviços do Babeiro
            $barber['services'] = BarberServices::select(['id','name','price'])
                ->where('id_barber',$barber->id)
                ->get();

            //pegando os depoimentos do Babeiro
            $barber['testimonials'] =BarberTestimonial::select(['id','name','rate','body'])
                ->where('id_barber',$barber->id)
                ->get();


            // pegando a disponibilidade
            $availability = [];

            // - pegando a disponibilidade crua
            $avails = BarberAvailabillity::where('id_barber',$barber->id)->get();
            foreach($avails as $item){
                $availWeekDays[$item['weekday']] = explode(',',$item['hours']);
            }

            //pegar os agendamentos do  proximos20 dias
            $appointments = [];

            $appQuery = UserAppointment::where('id_barber',$barber->id)
                ->whereBetween('ap_datetime',[
                date('Y-m-d').'00:00:00',
                date('Y-m-d',strtotime('+20 days')).'23:59:59'
                ])
                ->get();

            foreach($appQuery as $appItem){
                $appointments[] = $appItem['ap_datetime'];
            }

            // - Gera disponibilidade real

            for($q=0; $q<20; $q++){
            $timeItem = strtotime('+'.$q.'days');
            $weekDay = date('w', $timeItem);

                if(in_array($weekDay, array_keys($availWeekDays))){
                    $hours = [];

                    $dayItem = date('y-m-d',$timeItem);

                    foreach($availWeekDays[$weekDay] as $hourItem){
                        $dayFormated = $dayItem.' '.$hourItem.':00';
                        if(!in_array($dayFormated, $appointments)){
                            $hours[] = $hourItem;
                        }
                    }

                    if(count($hours) > 0){
                        $availability[] = [
                            'date'=> $dayItem,
                            'hours'=> $hours
                        ];
                    }
                }
            }

            $barber['available'] = $availability;
            $array['data'] = $barber;
        }else{
            $array['error'] = 'barbeiro nao existe';
            return $array;
        }
        return $array;
    }

    public function setAppointment($id, Request $request) {
        $array = ['error' => ''];
        $service = $request->input('service');
        $year = intval($request->input('year'));
        $month = intval($request->input('month'));
        $day = intval($request->input('day'));
        $hour = intval($request->input('hour'));
        $month = str_pad($month, 2, '0', STR_PAD_LEFT);
        $day = str_pad($day, 2, '0', STR_PAD_LEFT);
        $hour = str_pad($hour, 2, '0', STR_PAD_LEFT);
        //verificar se o servico do barbeiro existe
        $barberservice = BarberService::where('id', $service)
            ->where('id_barber', $id)
            ->first();
        if(!$barberservice) {
            $array['error'] = 'Serviço inexistente';
            return $array;
        }

        //verificar se a data é real
        $apDate = $year.'-'.$month.'-'.$day.' '.$hour.':00:00';
        echo $apDate;
        if(!strtotime($apDate) > 0) {
            $array['error'] = 'Data invalida!';
            return $array;
        }
        //vefificar se o barbeiro ja possui agendamento nesta data/hora
        $apps = UserAppointment::where('id_barber', $id)
            ->where('ap_datetime', $apDate)
            ->get();
        if(count($apps) > 0) {
            $array['error'] = 'Horário/dia indisponivel!';
            return $array;
        }
        //verificar se o barbeiro atende nesta data
        $weekDay = date('w', strtotime($apDate));
        $avail = BarberAvailability::select()
            ->where('id_barber', $id)
            ->where('weekday', $weekDay)
            ->first();
        if(!$avail) {
            $array['error'] = 'Barbeiro não atende neste dia!';
            return $array;
        }
        //Verificar se o barbeiro atende nesta hora
        $hours = explode(',', $avail['hours']);
        if(!in_array($hour.':00', $hours)){
            $array['error'] = 'Barbeiro não atende nesta hora!';
            return $array;
        }
        //fazer o agendamento
        $newApp = new UserAppointment();
        $newApp->id_user = $this->loggedUser->id;
        $newApp->id_barber = $id;
        $newApp->id_service = $service;
        $newApp->ap_datetime = $apDate;
        $newApp->save();
        return $array;
    }
}
