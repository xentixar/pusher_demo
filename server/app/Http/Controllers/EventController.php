<?php

namespace App\Http\Controllers;

use App\Events\SendNotification;
use Illuminate\Http\Request;

class EventController extends Controller
{
    public function broadcast()
    {
        event(new SendNotification('Hello world'));
        return 1;
    }
}
