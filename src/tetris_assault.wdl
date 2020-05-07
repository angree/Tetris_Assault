
SOUND  wiatr,<mus.wav>;
SOUND  click,<0_click.wav>;
SOUND  combo,<0_metal_crunch.wav>;

var gra=0;
var nr;
var r;
var zum = 7;
var tol; //tolerancja przy 'nacelowywaniu'
var zaw = 0; //aktywny zawodnik
var zaw2 = 1;
var muzyka;
var pos_x = 0;
var pos_y = 0;
var obrot = 0;
var obrot2 = 0;
var animacja[12];
var animspeed = 6;	//predkosc animacji;

var obrot3 = 0;
var klawisz = 0;
var spe = 0;
var lewo;
var prawo;
var prosto;
var cel[3];
var man_x[5535];
var man_y[5535];
var tar_x[5535];
var tar_y[5535];
var tar_z[5535];
var swiatlo[5535];
var tarx;
var tary;
var tarz;
var mysz_x; //mouse x
var mysz_y;
var mysz_z;
var miejsce_x[160];
var miejsce_y[160];
var uzywany[900];
var timer = 0;

var kursor_x; //wspolrzedne kursora
var kursor_y;

var v_0 = 0;
var level = 1;
var lev = 0;
var wysokosc = 0; //wysokosc 0-199 (loop)
var generuj = 0; //generuj nowa liniee (kiedy 1)
var plansza[160]; //plansza (nr_obiektu)
var plansza_k[160]; //plansza (kolor klocka 0-5)
var pl_t; //zmienna tymczasowa do tworzenia plansza_k
var a0;
var a1;
var a2;
var a3;
var a4;
var a5;
var a6;
var a7;
var a8;
var a9;

var a10;
var a11;
var a12;
var a13;
var a14;
var a15;
var a16;
var a17;
var a18;
var a19;
var a20;

var wyjscie=0;

var s0;
var s1;
var s2;
var s3;
var s4;
var s5;
var s6;
var s7;
var s8;
var s9;
var st0[40]; //pamiec klockow do kasowania
var st1 = 0;
var wys = 20; //wysokosc (kolumny)
var losowa =0;
var czas=0;
var czas16=0;
var czasm=0;
var widok=0; //przesuwanie ekranu
var widok1=0; //aktualny widok
var widok2=0; //tymcz zmienna

var klocek = 0;
var pauza = 0;
var vi = 0;
var vi1 = 0;
var litera;

var score=0;
var hiscore = 0;
string wyn = "SCORE  ";
string hi = "BEST   ";
string cza = "          -  ";
string cza2= "        TIME";
string le= "LEVEL";
string fir= "press right mouse button to start";
string gameover= "GAME OVER";
string pau= "PAUZA";
string loa="Loading...";
string podaj="ENTER YOUR NAME";


string imie[10];

string hsn1[10];   //hiscoresy (imiona)
string hsn2[10];
string hsn3[10];
string hsn4[10];
string hsn5[10];
string hsn6[10];
string hsn7[10];
string hsn8[10];
string hsn9[10];
string hsn10[10];

var hs1;  // hiscores (punkty)
var hs2;
var hs3;
var hs4;
var hs5;
var hs6;
var hs7;
var hs8;
var hs9;
var hs10;

var_nsave plikz;



path "c:\\GSTUDIO\\template";	// Path to WDL templates subdirectory

font czcionka = <msgfont.pcx>,12,16;
include <movement.wdl>;
include <messages.wdl>;
include <menu.wdl>;
include <particle.wdl>;
include <doors.wdl>;
include <actors.wdl>;
include <weapons.wdl>;
include <war.wdl>;
include <lflare.wdl>;

ACTION nic
{
	wait(1);
}


Function get_target() //get the target position on the level
{
	losowa=losowa+1;
	mouse_to_level();
	vec_set(cel,target);
	tar_z[900] = cel.z;
	if(cel.y>3999) { tar_z[900] = -100; }
	if(cel.x<401) { tar_z[900] = -100; }
	if(cel.x>1999) { tar_z[900]= -100; }
	if(tar_z[900]>-20)
	{
		tar_x[900] = cel.x;
		tar_y[900] = cel.y;
	}
	if(tar_x[900]<601)
	{	tar_x[900]=tar_x[900]+100; }
	if(tar_x[900]<601)
	{	tar_x[900]=tar_x[900]+100; }
	if(tar_x[900]>1899)
	{	tar_x[900]=tar_x[900]-100; }

	kursor_x=0;
	i=tar_x[900]-100;
	tar_x[900]=0;
	while(tar_x[900]<i)
	{
		tar_x[900]=tar_x[900]+200;
		kursor_x=kursor_x+1;
	}
	tar_x[900]=tar_x[900];
	kursor_x=kursor_x-3;

	kursor_y=0;
	i=tar_y[900];
	tar_y[900]=0;
	while(tar_y[900]-200+wysokosc<i)
	{
		tar_y[900]=tar_y[900]+200;
		kursor_y=kursor_y+1;
	}
	tar_y[900]=tar_y[900]-100-200+wysokosc;
	kursor_y=kursor_y-1;

}


Function badaj()
{
	mouse_to_level();
	vec_set(cel,target);
	mysz_x = cel.x;
	mysz_y = cel.y;
	mysz_z = cel.z;
	if(mysz_z<-20)
	{
		mysz_x=5535;
		mysz_y=5535;
	}
}

function kamera()
{
	if(pos_x > my.x)
	{
		if((pos_x-my.x)<10)
		{
			pos_x -= 1;
		}
		else
		{
			pos_x -= (pos_x-my.x)/2;
		}
	}
	else
	{
		if((my.x-pos_x)<10)
		{
			if((my.x-pos_x)>1)
			{
				pos_x += 1;
			}
		}
		else
		{
			pos_x += (my.x-pos_x)/2;
		}
	}
	if(pos_y > my.y)
	{
		if((pos_y-my.y)<10)
		{
			pos_y -= 1;
		}
		else
		{
			pos_y -= (pos_y-my.y)/2;
		}
	}
	else
	{
		if((my.y-pos_y)<10)
		{
			if((my.y-pos_y)>1)
			{
				pos_y += 1;
			}
		}
		else
		{
			pos_y += (my.y-pos_y)/2;
		}
	}
}


panel panel_pomocniczy
{
	digits = 50, 70, 12, czcionka, 1, score;
	digits = 50, 110, 12, czcionka, 1, hiscore;
	digits = 150, 35, 3, czcionka, 1, czasm;
	digits = 196, 35, 2, czcionka, 1, czas;

	digits = 105, 20, 2, czcionka, 1, Level;


	flags = overlay, refresh, visible;

}

panel hiscores
{
	digits = 380, 120, 12, czcionka, 1, hs1;
	digits = 380, 140, 12, czcionka, 1, hs2;
	digits = 380, 160, 12, czcionka, 1, hs3;
	digits = 380, 180, 12, czcionka, 1, hs4;
	digits = 380, 200, 12, czcionka, 1, hs5;
	digits = 380, 220, 12, czcionka, 1, hs6;
	digits = 380, 240, 12, czcionka, 1, hs7;
	digits = 380, 260, 12, czcionka, 1, hs8;
	digits = 380, 280, 12, czcionka, 1, hs9;
	digits = 380, 300, 12, czcionka, 1, hs10;

	flags = overlay, refresh, visible;
}

text hin
{
  pos_x = 350;  //320
  pos_y = 100;
  font = czcionka;
  string = "hiscores";
}
text hi1
{
  pos_x = 270;
  pos_y = 120;
  font = czcionka;
  string = hsn1;
}
text hi2
{
  pos_x = 270;
  pos_y = 140;
  font = czcionka;
  string = hsn2;
}
text hi3
{
  pos_x = 270;
  pos_y = 160;
  font = czcionka;
  string = hsn3;
}
text hi4
{
  pos_x = 270;
  pos_y = 180;
  font = czcionka;
  string = hsn4;
}
text hi5
{
  pos_x = 270;
  pos_y = 200;
  font = czcionka;
  string = hsn5;
}
text hi6
{
  pos_x = 270;
  pos_y = 220;
  font = czcionka;
  string = hsn6;
}
text hi7
{
  pos_x = 270;
  pos_y = 240;
  font = czcionka;
  string = hsn7;
}
text hi8
{
  pos_x = 270;
  pos_y = 260;
  font = czcionka;
  string = hsn8;
}
text hi9
{
  pos_x = 270;
  pos_y = 280;
  font = czcionka;
  string = hsn9;
}
text hi10
{
  pos_x = 270;
  pos_y = 300;
  font = czcionka;
  string = hsn10;
}


text loading
{
  pos_x = 284; //350+12*7
  pos_y = 200;
  font = _a4Font;
  string = loa;
}


text t_wynik
{
  pos_x = 45;
  pos_y = 70;
  font = czcionka;
  string = wyn;
}

text t_fire
{
  pos_x = 210; //350+12*7
  pos_y = 550;
  font = czcionka;
  string = fir;
}

text t_czas
{
  pos_x = 66;
  pos_y = 35;
  font = czcionka;
  string = cza;
}

text t_czas2
{
  pos_x = 72;
  pos_y = 15;
  font = czcionka;
  string = cza2;
}

text t_le
{
  pos_x = 33;
  pos_y = 20;
  font = czcionka;
  string = le;
}

text t_hi
{
  pos_x = 45;
  pos_y = 110;
  font = czcionka;
  string = hi;
}

text t_koniec
{
  pos_x = 322;
  pos_y = 280;
  font = czcionka;
  string = gameover;
}
text t_pauza
{
  pos_x = 322;
  pos_y = 280;
  font = czcionka;
  string = pau;
}
text t_imie
{
  pos_x = 322;
  pos_y = 280;
  font = czcionka;
  string = imie;
}

text t_podaj
{
  pos_x = 280;
  pos_y = 260;
  font = czcionka;
  string = podaj;
}

//POSTACIE

action lajt
{
	my.scale_x = 1.83;
	my.scale_y = 1.6;
	my.scale_z = 0.3;
	my.z=65;
	my.x=-10000;

	MY._FORCE=900;
	while(1)
	{
			losowa=losowa+1;
			if(my.x<tar_x[MY._FORCE])
			{
				if(((tar_x[MY._FORCE]-my.x)/(animspeed/2))<1)
				{
					my.x=my.x+1;
				}
				else
				{
					my.x=my.x+((tar_x[MY._FORCE]-my.x)/(animspeed/2));
				}
			}
			if(my.x>tar_x[MY._FORCE])
			{
				if(((0-tar_x[MY._FORCE]+my.x)/(animspeed/2))<1)
				{
					my.x=my.x-1;
				}
				else
				{
					my.x=my.x-((0-tar_x[MY._FORCE]+my.x)/(animspeed/2));
				}
			}

			if(my.y<tar_y[MY._FORCE])
			{
				if(((tar_y[MY._FORCE]-my.y)/(animspeed/2))<1)
				{
					my.y=my.y+1;
				}
				else
				{
					my.y=my.y+((tar_y[MY._FORCE]-my.y)/(animspeed/2));
				}
			}
			if(my.y>tar_y[MY._FORCE])
			{
				if(((0-tar_y[MY._FORCE]+my.y)/(animspeed/2))<1)
				{
					my.y=my.y-1;
				}
				else
				{
					my.y=my.y-((0-tar_y[MY._FORCE]+my.y)/(animspeed/2));
				}
			}

				my.lightrange=640-spe;
				my.red=40;
				my.green=40;
				my.blue=40;
		waitt(1);
	}
}



include <elementy.wdl>;

var video_mode = 7;	 // screen size 640x480
var video_depth = 16; // 16 bit colour D3D mode

string mission_str = "by aNGREe 2004, 2007";
string level_str = <strzelanka.WMB>; // give file names in angular brackets

bmap splashmap = <logodark.bmp>; // the default logo in templates
panel splashscreen {
	bmap = splashmap;
	flags = refresh,d3d;
}

bmap hi_bmp = <hiscores.bmp>;
panel hisc {
	bmap = hi_bmp;
	flags = refresh,d3d,transparent;
}

bmap panel_bmp = <panel_maly.bmp>;
panel pan {
	bmap = panel_bmp;
	flags = refresh,d3d,transparent;
	pos_x = 25;
	pos_y = 12;

}

bmap horizon_map = <palette.pcx>;

function init_environment()
{
	scene_map = horizon_map;	// horizon backdrop overlay
	scene_nofilter = on;

	sky_speed.x = 1;
	sky_speed.y = 1.5;
	cloud_speed.x = 3;
	cloud_speed.y = 4.5;

	sky_scale = 0.5;
	sky_curve = 1;  			// 'steepness' of sky dome

	scene_field = 60;  		// repeat map 6 times
	scene_angle.tilt = -10; // lower edge of scene_map 10 units below horizon

	sky_clip = scene_angle.tilt;	// clip the sky at bottom of scene_map
}

function main()
{
score = 0;

	tex_share = on;	// map entities share their textures
	splashscreen.pos_x = (screen_size.x - bmap_width(splashmap))/2;
	splashscreen.pos_y = (screen_size.y - bmap_height(splashmap))/2;
	splashscreen.visible = ON;
	panel_pomocniczy.visible = OFF;
	hiscores.visible = OFF;
	wait(3);

	init_environment();
	level_load(level_str);
	freeze_mode = 1;
	waitt(10);

	loading.visible = ON;


	load_status();
	msg_show(mission_str,10);
	ifdef CAPS_FLARE;
		lensflare_start();
	endif;

	freeze_mode = 0;
	d3d_lightres=1;
	snd_loop (wiatr, 40, 0);
	tar_x[0]=0;
	tar_y[0]=0;
	tar_x[1] = -1000;
	tar_y[1] = -1000;
	temp.z = 30;
	temp.pan = 90;
	temp.tilt = 0;
	temp.roll = 0;

	camera.x = 0-(312*zum*0.25*0)+1000;
	camera.y = 0-(625*zum*0.25)+1000;
	camera.z = (1250*zum*0.25);
	camera.pan = 90;
	camera.tilt = -68;
	camera.roll = 0;
	tar_x[900]=-10000;

	temp.z = 30;
	temp.x = 0;
	temp.y = 0;
	ent_create("nic.MDL",temp,lajt);

	temp.x = 65535;
	temp.y = 65535;
	temp.z = 65;

	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);
	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);
	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);
	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);	ent_create("k_czer.MDL",temp,postac0);

	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);
	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);
	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);
	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);	ent_create("k_nieb.MDL",temp,postac0);

	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);
	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);
	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);
	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);	ent_create("k_fiol.MDL",temp,postac0);

	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);
	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);
	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);
	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);	ent_create("k_ziel.MDL",temp,postac0);

	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);
	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);
	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);
	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);	ent_create("k_zolt.MDL",temp,postac0);

	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);
	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);
	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);
	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);	ent_create("k_czarny.MDL",temp,postac0);

// wczytywanie hiscores (zrobic)
plikz = file_open_read("scores1.dat");

if(plikz == 0)
{

str_cpy(hsn1,"angree");
str_cpy(hsn2,"angree");
str_cpy(hsn3,"angree");
str_cpy(hsn4,"angree");
str_cpy(hsn5,"angree");
str_cpy(hsn6,"angree");
str_cpy(hsn7,"angree");
str_cpy(hsn8,"angree");
str_cpy(hsn9,"angree");
str_cpy(hsn10,"angree");

hs1 = 10000; hs2 = 9000; hs3 = 8000; hs4 = 7000; hs5 = 6000; hs6 = 5000; hs7 = 4000; hs8 = 3000; hs9 = 2000; hs10 = 1000;

}
else
{
file_str_read(plikz,hsn1);
file_str_read(plikz,hsn2);
file_str_read(plikz,hsn3);
file_str_read(plikz,hsn4);
file_str_read(plikz,hsn5);
file_str_read(plikz,hsn6);
file_str_read(plikz,hsn7);
file_str_read(plikz,hsn8);
file_str_read(plikz,hsn9);
file_str_read(plikz,hsn10);

file_close(plikz);
plikz = file_open_read("scores2.dat");

hs1 = file_var_read(plikz);
hs2 = file_var_read(plikz);
hs3 = file_var_read(plikz);
hs4 = file_var_read(plikz);
hs5 = file_var_read(plikz);
hs6 = file_var_read(plikz);
hs7 = file_var_read(plikz);
hs8 = file_var_read(plikz);
hs9 = file_var_read(plikz);
hs10 = file_var_read(plikz);


file_close(plikz);

}

hiscore=hs1;
mouse_toggle();

	i=0;
	while(i<160)
	{
		plansza[i]=-1;
		i=i+1;
	}

	i=0;
	while(i<900)
	{
		tar_x[i]=65535;
		tar_y[i]=65535;
		tar_z[i]=65;
		uzywany[i]=-1;
		i=i+1;
	}

	a0=100;
	a1=500;
	a2=0;
	while(a0<4000)
	{
		a1=500;
		while(a1<2000)
		{
			miejsce_x[a2]=a1;
			miejsce_y[a2]=a0;
			a2=a2+1;
			a1=a1+200;
		}
		a0=a0+200;
	}

			timer=0; //tar_x[900];
	generuj=0;
	loading.visible = OFF;

pan.visible = on;
pan.transparent = on;
pan.alpha = 0;


while(1)
{
score = 0;

plikz = file_open_write ("scores1.dat");

file_str_write (plikz,hsn1);
file_str_write (plikz,",");
file_str_write (plikz,hsn2);
file_str_write (plikz,",");
file_str_write (plikz,hsn3);
file_str_write (plikz,",");
file_str_write (plikz,hsn4);
file_str_write (plikz,",");
file_str_write (plikz,hsn5);
file_str_write (plikz,",");
file_str_write (plikz,hsn6);
file_str_write (plikz,",");
file_str_write (plikz,hsn7);
file_str_write (plikz,",");
file_str_write (plikz,hsn8);
file_str_write (plikz,",");
file_str_write (plikz,hsn9);
file_str_write (plikz,",");
file_str_write (plikz,hsn10);
file_str_write (plikz,",");

file_close (plikz);

plikz = file_open_write ("scores2.dat");

file_var_write(plikz,hs1);
file_var_write(plikz,hs2);
file_var_write(plikz,hs3);
file_var_write(plikz,hs4);
file_var_write(plikz,hs5);
file_var_write(plikz,hs6);
file_var_write(plikz,hs7);
file_var_write(plikz,hs8);
file_var_write(plikz,hs9);
file_var_write(plikz,hs10);

file_close (plikz);





	i=0;
	while(i<900)
	{
		tar_x[i]=65535;
		tar_y[i]=65535;
		tar_z[i]=65;
		uzywany[i]=-1;
		i=i+1;
	}
	a0=100;
	a1=500;
	a2=0;
	while(a0<4000)
	{
		a1=500;
		while(a1<2000)
		{
			miejsce_x[a2]=a1;
			miejsce_y[a2]=a0;
			a2=a2+1;
			a1=a1+200;
		}
		a0=a0+200;
	}
	score=0;
	level=1;
	wysokosc=0;
	widok=0;
	lev = 0;
	generuj = 1;
	a9=0;
	czas=0;
	czasm=0;
	czas16=0;
	i=0;
	v_0=0;
	while(i<8*wys)
	{
		plansza[i]=-1;
		i=i+1;
	}

	i=0;
	while(i<900)
	{
		tar_x[i]=65535;
		tar_y[i]=65535;
		tar_z[i]=65;
		uzywany[i]=-1;
		i=i+1;
	}
	wyjscie=0;

	t_fire.visible = ON;


//menu

pl_t=1000;
splashscreen.transparent = ON;
splashscreen.alpha = 100;
	hisc.visible = ON;
	hisc.alpha = 0;


	while(!(Mouse_right))
	{


if((pl_t<900) && (pl_t>=800))
{
	if (splashscreen.alpha > 0)
	{
	splashscreen.alpha -= 2;
	}
}

if((pl_t<800) && (pl_t>=700))
{
	if(pl_t==799)
	{
	hisc.visible = ON;
	hisc.alpha = 0;

	hiscores.visible = ON;
	hin.visible = ON;
	hi1.visible = ON;
	hi2.visible = ON;
	hi3.visible = ON;
	hi4.visible = ON;
	hi5.visible = ON;
	hi6.visible = ON;
	hi7.visible = ON;
	hi8.visible = ON;
	hi9.visible = ON;
	hi10.visible = ON;

	hiscores.transparent = ON;
	hin.transparent = ON;
	hi1.transparent = ON;
	hi2.transparent = ON;
	hi3.transparent = ON;
	hi4.transparent = ON;
	hi5.transparent = ON;
	hi6.transparent = ON;
	hi7.transparent = ON;
	hi8.transparent = ON;
	hi9.transparent = ON;
	hi10.transparent = ON;

	}

	if (hisc.alpha < 70)
	{
		hisc.alpha += 2;

	}
}

if((pl_t<400) && (pl_t>=300))
{

	if (hisc.alpha > 0)
	{
		hisc.alpha -= 2;
	}
	if (hisc.alpha < 10)
	{
	hiscores.visible = OFF;
	hin.visible = OFF;
	hi1.visible = OFF;
	hi2.visible = OFF;
	hi3.visible = OFF;
	hi4.visible = OFF;
	hi5.visible = OFF;
	hi6.visible = OFF;
	hi7.visible = OFF;
	hi8.visible = OFF;
	hi9.visible = OFF;
	hi10.visible = OFF;
	}
}

if((pl_t<200) && (pl_t>=100))
{
	if (splashscreen.alpha < 100)
	{
	splashscreen.alpha += 2;
	}
}


pl_t -= 1;

if(pl_t<1)
{
	pl_t=1000;
}

waitt(1);

}



	hisc.alpha = 0;
	hiscores.visible = OFF;
	hin.visible = OFF;
	hi1.visible = OFF;
	hi2.visible = OFF;
	hi3.visible = OFF;
	hi4.visible = OFF;
	hi5.visible = OFF;
	hi6.visible = OFF;
	hi7.visible = OFF;
	hi8.visible = OFF;
	hi9.visible = OFF;
	hi10.visible = OFF;




while (splashscreen.alpha > 0)
{
splashscreen.alpha -= 2;
wait(1);
}

pan.alpha = 70;

pl_t =0;



	t_fire.visible = OFF;


	hiscores.visible = OFF;

	hin.visible = OFF;
	hi1.visible = OFF;
	hi2.visible = OFF;
	hi3.visible = OFF;
	hi4.visible = OFF;
	hi5.visible = OFF;
	hi6.visible = OFF;
	hi7.visible = OFF;
	hi8.visible = OFF;
	hi9.visible = OFF;
	hi10.visible = OFF;

	t_wynik.visible = ON;
	t_czas.visible = ON;
	t_czas2.visible = ON;
	t_le.visible = ON;
	t_hi.visible = ON;
	panel_pomocniczy.visible = ON;


	while(wyjscie<1)
	{
		if(level>98)
		{
			level=98;
		}
		if(score>1799999)
		{
			score=1799999;
		}
		gra=1;
		losowa=losowa+1;
		a10 = plansza[0]*10;
		a11 = plansza[1]*10;
		a12 = plansza[2]*10;
		a13 = plansza[3]*10;
		a14 = plansza[4]*10;
		a15 = plansza[5]*10;
		a16 = plansza[6]*10;
		a17 = plansza[7]*10;


			if(v_0<(0.9+(level*0.05)))  //*0.2
			{
				if(level>6)
				{ v_0=v_0+0.006+0.00075*((level-6)/2); }
				else
				{ v_0=v_0+0.006; }
			}
			if(v_0>=0)
			{
				score=score+0.05;
				wysokosc=wysokosc+v_0;
			}
			widok=0;
			a3=0;
			widok2=0;
			widok=0;
			while(a3<8)
			{
				if(plansza[56+a3]>-1) { widok2=wysokosc;
				if(plansza[64+a3]>-1) { widok2=wysokosc+200;
				if(plansza[72+a3]>-1) { widok2=wysokosc+400;    //////// dorobic jesli plansza powiekszona
				if(plansza[80+a3]>-1) { widok2=wysokosc+600;
				if(plansza[88+a3]>-1) { widok2=wysokosc+800;
				if(plansza[96+a3]>-1) { widok2=wysokosc+1000;
				if(plansza[104+a3]>-1) { widok2=wysokosc+1200;
				if(plansza[112+a3]>-1) { widok2=wysokosc+1400;
				if(plansza[120+a3]>-1) { widok2=wysokosc+1600;
				if(plansza[128+a3]>-1) { widok2=wysokosc+1800;
				if(plansza[136+a3]>-1) { widok2=wysokosc+2000;
				if(plansza[144+a3]>-1) { widok2=wysokosc+2200;
				if(plansza[152+a3]>-1) { widok2=2400;
				} } } } } } } } } } } } }
				a3=a3+1;
				if(widok2>widok) { widok=widok2; }
			}

			if(wysokosc>199)
			{
			 a9=0;
			 wysokosc=wysokosc-200; generuj=1;
			 a3=0;
			 while(a3<8)
			 {
				if(plansza[152+a3]>-1) { wyjscie=1; }
				plansza[152+a3]=plansza[144+a3];
				plansza[144+a3]=plansza[136+a3];
				plansza[136+a3]=plansza[128+a3];
				plansza[128+a3]=plansza[120+a3];
				plansza[120+a3]=plansza[112+a3];
				plansza[112+a3]=plansza[104+a3];
				plansza[104+a3]=plansza[96+a3];
				plansza[96+a3]=plansza[88+a3];
				plansza[88+a3]=plansza[80+a3];
				plansza[80+a3]=plansza[72+a3];
				plansza[72+a3]=plansza[64+a3];
				plansza[64+a3]=plansza[56+a3];
				plansza[56+a3]=plansza[48+a3];
				plansza[48+a3]=plansza[40+a3];
				plansza[40+a3]=plansza[32+a3];
				plansza[32+a3]=plansza[24+a3];
				plansza[24+a3]=plansza[16+a3];
				plansza[16+a3]=plansza[8+a3];
				plansza[8+a3]=plansza[a3];
				plansza[a3]=-1;
				a3=a3+1;
			 }
			}
			spe+=1;
			if(spe>11) { spe=0; }

//generowanie nowej linii
			pl_t=0;
			while(pl_t<160)
			{
				if( (plansza[pl_t]>=0) && (plansza[pl_t]<=39) )
				{ plansza_k[pl_t]=0; }
				if( (plansza[pl_t]>=40) && (plansza[pl_t]<=79) )
				{ plansza_k[pl_t]=1; }
				if( (plansza[pl_t]>=80) && (plansza[pl_t]<=119) )
				{ plansza_k[pl_t]=2; }
				if( (plansza[pl_t]>=120) && (plansza[pl_t]<=159) )
				{ plansza_k[pl_t]=3; }
				if( (plansza[pl_t]>=160) && (plansza[pl_t]<=199) )
				{ plansza_k[pl_t]=4; }
				if( (plansza[pl_t]>=200) && (plansza[pl_t]<=239) )
				{ plansza_k[pl_t]=5; }
				pl_t=pl_t + 1;
			}

			if (generuj==1)
			{
				if(a9==0)
				{
					lev=lev+1;
				}
				a5=0;
				a3=timer;
				while(a3<0)
				{
					a3=a3+1000;
				}
				while(a3>=6)
				{
					a3=a3-6;
				}
				a4=a3*40;
				if(a4>239) { a4=a4-200; }
				if(a4>239) { a4=a4-200; }
				if(a4>239) { a4=a4-200; }
				if(a4>239) { a4=a4-200; }
				if(a4>239) { a4=0; }

				if( (a4>=0) && (a4<=39) )
				{ pl_t=0; }
				if( (a4>=40) && (a4<=79) )
				{ pl_t=1; }
				if( (a4>=80) && (a4<=119) )
				{ pl_t=2; }
				if( (a4>=120) && (a4<=159) )
				{ pl_t=3; }
				if( (a4>=160) && (a4<=199) )
				{ pl_t=4; }
				if( (a4>=200) && (a4<=239) )
				{ pl_t=5; }

				if(a9>1) //jesli jest gen. 3ci klocek lub pozniejszy sprawdz cz ynie tworzy linii z 2ma poprzednimi
				{
					while( (uzywany[a4]>-1) || ((pl_t==plansza_k[8+a9]) && (pl_t==plansza_k[16+a9])) || ( (pl_t==plansza_k[a9-1]) && (pl_t==plansza_k[a9-2]) ) )
					{
						a4=a4+1;
						if(a4>238) { a4=0; }

						if( (a4>=0) && (a4<=39) )
						{ pl_t=0; }
						if( (a4>=40) && (a4<=79) )
						{ pl_t=1; }
						if( (a4>=80) && (a4<=119) )
						{ pl_t=2; }
						if( (a4>=120) && (a4<=159) )
						{ pl_t=3; }
						if( (a4>=160) && (a4<=199) )
						{ pl_t=4; }
						if( (a4>=200) && (a4<=239) )
						{ pl_t=5; }
					}
				}
				else  //jesli jest to drugi lub 1. sprawdzaj tylko pionowo
				{
					while( (uzywany[a4]>-1) || ((pl_t==plansza_k[8+a9]) && (pl_t==plansza_k[16+a9])) )
					{
						a4=a4+1;
						if(a4>238) { a4=0; }

						if( (a4>=0) && (a4<=39) )
						{ pl_t=0; }
						if( (a4>=40) && (a4<=79) )
						{ pl_t=1; }
						if( (a4>=80) && (a4<=119) )
						{ pl_t=2; }
						if( (a4>=120) && (a4<=159) )
						{ pl_t=3; }
						if( (a4>=160) && (a4<=199) )
						{ pl_t=4; }
						if( (a4>=200) && (a4<=239) )
						{ pl_t=5; }
					}
				}

				uzywany[a4]=0;
				plansza[a9]=a4;
				plansza_k[a9]=pl_t;
				a9=a9+1;
				if(a9>7) {generuj=0; a9=0; }
			}

			a7=0;
			while(a7<wys)
			{
				a8=0;
				while(a8<8)
				{
					if(plansza[a8+(a7*8)]>-1)
					{
						a20=(plansza[a8+(a7*8)]); a19=a8+(a7*8);
						tar_x[a20]=miejsce_x[a19];
						tar_y[a20]=miejsce_y[a19]-200+wysokosc;
					}
					a8=a8+1;
				}
				a7=a7+1;
			}
			//

			while(pauza>0)
			{
				t_pauza.visible= ON;
				waitt(1);
			}
			t_pauza.visible= OFF;
			grawitacja();

			sprawdzaj();

			grawitacja();

			a7=0;
			while(a7<mysz_x+mysz_y)
			{
				if((a7+1001)>(mysz_x+mysz_y))
				{
					a7=a7+1000;
				}
				if((a7+100)>(mysz_x+mysz_y))
				{
					a7=a7+100;
				}
				else
				{
					a7=a7+1;
				}
			}
			while(losowa>5000) { losowa=losowa-4999; }
			timer=timer+a7+1+losowa;
			while (timer>5000) { timer=timer-5000; }
			if(widok1<widok-1)
			{
				widok1=widok1+1;
			}
			if(widok1>widok)
			{
				widok1=widok1-2;
			}
			if(widok1<0) { widok1=0; }
			camera.x = 0-(312*zum*0.25*0)+1000;
			camera.y = 0-(625*zum*0.25)+1000+widok1;
			camera.z = (1250*zum*0.25);
			//camera.pan -= key_force;
			camera.pan = 90;
			camera.tilt = -68;
			camera.roll = 0;
			badaj();
			get_target();
			czas16=czas16+1;
			if(czas16>32)
			{ czas16=0; czas=czas+1; }
			if(czas>60)
			{
				czasm=czasm+1;
				czas=0;
			}
			if(lev>9)
			{ level=level+1; lev=0;}
			if(score>hiscore)
			{ hiscore=score; }
			waitt(1);               //waitt
	}
	gra=0;
	t_wynik.visible = OFF;
	t_czas.visible = OFF;
	t_czas2.visible = OFF;
	t_le.visible = OFF;
	t_hi.visible = OFF;
	panel_pomocniczy.visible = OFF;
        pan.alpha = 0;

	t_koniec.visible = ON;
	waitt(10);
	while(!Mouse_left)
	{
		waitt(1);
	}
	t_koniec.visible = OFF;

if(score>hs10)
{

str_cpy(imie,"");
t_podaj.visible = ON;
t_imie.visible = ON;
vi = 0;
while(vi<10)
{
	vi1=vi;
	if((key_pressed(key_for_str("a"))) != 0)
	{
		litera = key_for_str("a");
		str_cat(imie,"a");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("b"))) != 0)
	{
		litera = key_for_str("b");
		str_cat(imie,"b");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("c"))) != 0)
	{
		litera = key_for_str("c");
		str_cat(imie,"c");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("d"))) != 0)
	{
		litera = key_for_str("d");
		str_cat(imie,"d");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("e"))) != 0)
	{
		litera = key_for_str("e");
		str_cat(imie,"e");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("f"))) != 0)
	{
		litera = key_for_str("f");
		str_cat(imie,"f");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("g"))) != 0)
	{
		litera = key_for_str("g");
		str_cat(imie,"g");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("h"))) != 0)
	{
		litera = key_for_str("h");
		str_cat(imie,"h");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("i"))) != 0)
	{
		litera = key_for_str("i");
		str_cat(imie,"i");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("j"))) != 0)
	{
		litera = key_for_str("j");
		str_cat(imie,"j");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("k"))) != 0)
	{
		litera = key_for_str("k");
		str_cat(imie,"k");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("l"))) != 0)
	{
		litera = key_for_str("l");
		str_cat(imie,"l");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("m"))) != 0)
	{
		litera = key_for_str("m");
		str_cat(imie,"m");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("n"))) != 0)
	{
		litera = key_for_str("n");
		str_cat(imie,"n");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("o"))) != 0)
	{
		litera = key_for_str("o");
		str_cat(imie,"o");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("p"))) != 0)
	{
		litera = key_for_str("p");
		str_cat(imie,"p");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("q"))) != 0)
	{
		litera = key_for_str("q");
		str_cat(imie,"q");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("r"))) != 0)
	{
		litera = key_for_str("r");
		str_cat(imie,"r");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("s"))) != 0)
	{
		litera = key_for_str("s");
		str_cat(imie,"s");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("t"))) != 0)
	{
		litera = key_for_str("t");
		str_cat(imie,"t");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("u"))) != 0)
	{
		litera = key_for_str("u");
		str_cat(imie,"u");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("w"))) != 0)
	{
		litera = key_for_str("w");
		str_cat(imie,"w");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("x"))) != 0)
	{
		litera = key_for_str("x");
		str_cat(imie,"x");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("y"))) != 0)
	{
		litera = key_for_str("y");
		str_cat(imie,"y");
		vi = vi + 1;
	}
	if((key_pressed(key_for_str("z"))) != 0)
	{
		litera = key_for_str("z");
		str_cat(imie,"z");
		vi = vi + 1;
	}

	if((key_pressed(14)) != 0)
	{
		litera = 14;
		str_trunc(imie,1);
		vi = vi - 1;
	}





	if((key_pressed(28)) != 0)
	{
		vi = 10;
		vi1= 10;
	}
//	t_imie.visible = OFF;
//	t_imie.visible = ON;
	if(vi1 != vi)
	{
		while((key_pressed(litera)) != 0)
		{
			waitt(1);
		}
	}
	waitt(1);
}

t_imie.visible = OFF;
t_podaj.visible = OFF;

pl_t=0;  //jesli 0- wynik jeszcze nie wstawiony, 1-juz wstawiony

if((score>hs1) && (pl_t==0))
{
	hs10=hs9;
	hs9=hs8;
	hs8=hs7;
	hs7=hs6;
	hs6=hs5;
	hs5=hs4;
	hs4=hs3;
	hs3=hs2;
	hs2=hs1;
	hs1=score;
	str_cpy(hsn10,hsn9);
	str_cpy(hsn9,hsn8);
	str_cpy(hsn8,hsn7);
	str_cpy(hsn7,hsn6);
	str_cpy(hsn6,hsn5);
	str_cpy(hsn5,hsn4);
	str_cpy(hsn4,hsn3);
	str_cpy(hsn3,hsn2);
	str_cpy(hsn2,hsn1);
	str_cpy(hsn1,imie);
	pl_t=1;
}
if((score>hs2) && (pl_t==0))
{
	hs10=hs9;
	hs9=hs8;
	hs8=hs7;
	hs7=hs6;
	hs6=hs5;
	hs5=hs4;
	hs4=hs3;
	hs3=hs2;
	hs2=score;
	str_cpy(hsn10,hsn9);
	str_cpy(hsn9,hsn8);
	str_cpy(hsn8,hsn7);
	str_cpy(hsn7,hsn6);
	str_cpy(hsn6,hsn5);
	str_cpy(hsn5,hsn4);
	str_cpy(hsn4,hsn3);
	str_cpy(hsn3,hsn2);
	str_cpy(hsn2,imie);
	pl_t=1;
}
if((score>hs3) && (pl_t==0))
{
	hs10=hs9;
	hs9=hs8;
	hs8=hs7;
	hs7=hs6;
	hs6=hs5;
	hs5=hs4;
	hs4=hs3;
	hs3=score;
	str_cpy(hsn10,hsn9);
	str_cpy(hsn9,hsn8);
	str_cpy(hsn8,hsn7);
	str_cpy(hsn7,hsn6);
	str_cpy(hsn6,hsn5);
	str_cpy(hsn5,hsn4);
	str_cpy(hsn4,hsn3);
	str_cpy(hsn3,imie);
	pl_t=1;
}
if((score>hs4) && (pl_t==0))
{
	hs10=hs9;
	hs9=hs8;
	hs8=hs7;
	hs7=hs6;
	hs6=hs5;
	hs5=hs4;
	hs4=score;
	str_cpy(hsn10,hsn9);
	str_cpy(hsn9,hsn8);
	str_cpy(hsn8,hsn7);
	str_cpy(hsn7,hsn6);
	str_cpy(hsn6,hsn5);
	str_cpy(hsn5,hsn4);
	str_cpy(hsn4,imie);
	pl_t=1;
}
if((score>hs5) && (pl_t==0))
{
	hs10=hs9;
	hs9=hs8;
	hs8=hs7;
	hs7=hs6;
	hs6=hs5;
	hs5=score;
	str_cpy(hsn10,hsn9);
	str_cpy(hsn9,hsn8);
	str_cpy(hsn8,hsn7);
	str_cpy(hsn7,hsn6);
	str_cpy(hsn6,hsn5);
	str_cpy(hsn5,imie);
	pl_t=1;
}
if((score>hs6) && (pl_t==0))
{
	hs10=hs9;
	hs9=hs8;
	hs8=hs7;
	hs7=hs6;
	hs6=score;
	str_cpy(hsn10,hsn9);
	str_cpy(hsn9,hsn8);
	str_cpy(hsn8,hsn7);
	str_cpy(hsn7,hsn6);
	str_cpy(hsn6,imie);
	pl_t=1;
}
if((score>hs7) && (pl_t==0))
{
	hs10=hs9;
	hs9=hs8;
	hs8=hs7;
	hs7=score;
	str_cpy(hsn10,hsn9);
	str_cpy(hsn9,hsn8);
	str_cpy(hsn8,hsn7);
	str_cpy(hsn7,imie);
	pl_t=1;
}
if((score>hs8) && (pl_t==0))
{
	hs10=hs9;
	hs9=hs8;
	hs8=score;
	str_cpy(hsn10,hsn9);
	str_cpy(hsn9,hsn8);
	str_cpy(hsn8,imie);
	pl_t=1;
}
if((score>hs9) && (pl_t==0))
{
	hs10=hs9;
	hs9=score;
	str_cpy(hsn10,hsn9);
	str_cpy(hsn9,imie);
	pl_t=1;
}
if((score>hs9) && (pl_t==0))
{
	hs10=score;
	str_cpy(hsn10,imie);
	pl_t=1;
}

//zapis pliku przeniesiony na poczatek petli

}

	widok=0;
	while(widok1>widok)
	{
		camera.y = 0-(625*zum*0.25)+1000+widok1;
		widok1=widok1-(widok1/2)-1;
	}
	widok1=0;
	camera.y = 0-(625*zum*0.25)+1000+widok;
}

}

var tmp;
var tmp2;
var i;


function zamiana
{
	if((kursor_y>-1) && (kursor_y<20) && (kursor_x>-1) && (kursor_x<7))
	{
		a7=plansza[kursor_x+(kursor_y*8)];
		plansza[kursor_x+(kursor_y*8)]=plansza[kursor_x+(kursor_y*8)+1];
		plansza[kursor_x+(kursor_y*8)+1]=a7;
		if(score!=0)
		{
		snd_play(click, 10, 0);
		}
	}
}

function sprawdzaj
{
	s0=0;
	s1=0;
	st1=0; //czyszczenie pamieci skasowanych klockow

	while(s1<20)
	{
	 s0=0;
	 s4=-1;
	 s5=1;
	 while(s0<8)
	 {
		 s3=plansza[s0+(s1*8)];

		 s6=s3;
		 s3=0;
		 while(s6>=40)
		 {
			s6=s6-40;
			s3=s3+1;
		 }
		 if(plansza[s0+(s1*8)]<0)
		 { s3=-1; }

		 if((s3==s4) && (plansza[s0+(s1*8)]>-1))
		 {
			s5=s5+1;
		 }
		 else
		 {
			if(s5>2)
			{
				while(s5>0)
				{
					st0[st1]=s0+(s1*8)-s5;
					st1=st1+1;
					//uzywany[(plansza[s0+(s1*8)-s5])]=-1;
					//plansza[s0+(s1*8)-s5]=-1;
					s5=s5-1;
					snd_play(combo, 7, 0);

				}
			}
			s5=1;
		 }
		 s4=s3;
		s0=s0+1;
	 }
	 if(s5>2)
	 {
		while(s5>0)
		{
			st0[st1]=s0+(s1*8)-s5;
			st1=st1+1;
			//uzywany[(plansza[s0+(s1*8)-s5])]=-1;
			//plansza[s0+(s1*8)-s5]=-1;
			s5=s5-1;
		}
	 }
	 s5=1;
	 s1=s1+1;
	}

//-

	s0=0;
	s1=0;

	while(s0<8)
	{
	 s1=0;
	 s4=-1;
	 s5=1;
	 while(s1<20)
	 {
		 s3=plansza[s0+(s1*8)];

		 s6=s3;
		 s3=0;
		 while(s6>=40)
		 {
			s6=s6-40;
			s3=s3+1;
		 }
		 if(plansza[s0+(s1*8)]<0)
		 { s3=-1; }

		 if((s3==s4) && (plansza[s0+(s1*8)]>-1))
		 {
			s5=s5+1;
		 }
		 else
		 {
			if(s5>2)
			{
				while(s5>0)
				{
					st0[st1]=s0+(s1*8)-(s5*8);
					st1=st1+1;
					//uzywany[(plansza[s0+(s1*8)-(s5*8)])]=-1;
					//plansza[s0+(s1*8)-(s5*8)]=-1;
					s5=s5-1;
					snd_play(combo, 7, 0);
				}
			}
			s5=1;
		 }
		 s4=s3;

		s1=s1+1;
	 }
	 if(s5>2)
	 {
		while(s5>0)
		{
			st0[st1]=s0+(s1*8)-(s5*8);
			st1=st1+1;
			//uzywany[(plansza[s0+(s1*8)-(s5*8)])]=-1;
			//plansza[s0+(s1*8)-(s5*8)]=-1;
			s5=s5-1;
		}
	 }
	 s5=1;
	 s0=s0+1;
	}
//-

s0=0;
while(s0<st1)
{
	if(plansza[(st0[s0])]>-1)
	{
		uzywany[(plansza[(st0[s0])])]=-1;
		plansza[(st0[s0])]=-1;
		v_0=v_0-(0.06*(s0+1));
		score=score+10*(s0+1)*level;
	}
	s0=s0+1;
}
st1=0;


}

function grawitacja
{
	s0=0;
	s1=wys-1;
	while(s0<8)
	{
	 if(generuj==1)
	 {
		s3=0;
	 }
	 else
	 {
		s3=-1;
	 }
	 s1=wys-1;
	 while(s1>s3)
	 {
		if(plansza[s0+(s1*8)]<0)
		{
			s2=s1;
			while(s2<wys-1)
			{
				plansza[s0+(s2*8)]=plansza[s0+((s2+1)*8)];
				if(s2==wys-2)
				{
					plansza[s0+((s2+1)*8)]=-1;
				}
				s2=s2+1;
			}
		}
		s1=s1-1;
	 }
	 s0=s0+1;
	}
}
function zawodnik1 { zaw=1; } //funkcja ktora nic nie robi

function pauz
{
	if((score>10)&&(gra>0)) {
		if(pauza>0) { pauza=0; } else { pauza=1; }
	}
}

On_mouse_left  zamiana();
On_mouse_right  pauz();
On_F1  zawodnik1;
On_F2  zawodnik1;
On_F3  zawodnik1;
On_F4  zawodnik1;
On_F5  zawodnik1; //blokowanie dzialania F-ow
On_F6  zawodnik1;
On_F7  zawodnik1;
On_F8  zawodnik1;
On_F9  zawodnik1;
On_F10  zawodnik1;
