program servotest;
uses delay;
const
  Min_pulse = 800;
  Max_pulse = 5000;
var
  tik:integer;
  i:integer;
  pbr:integer;
procedure Timer0_Interrupt; public name 'TIMER0_COMPA_ISR'; interrupt;
  begin
    TCNT0 := $54;
    PORTD := PORTD or (1 shl 4);
    delay_us(tik);
    PORTD := PORTD and not (1 shl 4);
  end;
function mapg(i:integer):integer;
  begin
  if i = 0 then mapg := Min_pulse
  else
      if i >180 then mapg := Max_pulse
      else
         mapg := Min_pulse+(i*pbr);
  end;

begin
   asm
     cli
   end;


   DDRD := DDRD or (1 shl 4);
    pbr:=23;
   // Initialize timer0
   TCCR0A := 0;                        // Normal mode
   TCCR0B := %101;                     // CPU clock / 1024
   TIMSK0  := TIMSK0 or (1 shl OCIE0A);  // Timer0 should trigger an interrupt
   //TIMSK0 := (1 shl TOIE0);
asm
    sei
  end;
PORTD := PORTD or (1 shl 4);
while true do begin
tik:=mapg(180);
delay_ms(10000);
tik:=mapg(0);
 delay_ms(10000);
tik:=mapg(90);
 delay_ms(10000);
 tik:=mapg(180);
delay_ms(10000);
tik:=mapg(0);
 delay_ms(10000);
tik:=mapg(45);
 delay_ms(10000);
 tik:=mapg(90);
delay_ms(10000);
tik:=mapg(135);
 delay_ms(10000);
tik:=mapg(180);
 delay_ms(10000);
 end;
end.

