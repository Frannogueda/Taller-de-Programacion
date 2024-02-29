program ejecicio ;
	const 
		df=50;
	type 
		RangoQ=1..15;
		RangoV=1..99;
		venta=record 
			dia:integer;
			codigoP:RangoQ;
			cantV:RangoV;
		end;

		Vventas=array[1..df]of venta;
	
	procedure leerventa(var a:venta);
		begin
			a.dia:=random(31);
			writeln('el dia ingresado fue: ',a.dia);
			if(a.dia<>0)then begin
				a.codigoP:=random(16);
				writeln('el codigo ingresado fue: ',a.codigoP);
				a.cantV:=random(100);
				writeln('ingresar el cantidad vendida: ');
			end;
		end;
		
	procedure cargarvalores(var v:Vventas; var dl:integer);
		var
			a:venta; i:integer;
		begin
			leerventa(a);
			i:=0;
			while(a.dia<>0)and(i<df)do begin
				v[i]:=a;
				i:=i+1;
				leerventa(a);
			end;
			dl:=i;
		end;
		
	procedure informarV(v:Vventas; dl:integer);
		var
			j:integer;
		begin
			for j:= 1 to dl do begin
				writeln('el dia fue: ',v[j].dia);
				writeln('el codigo fue: ',v[j].codigoP);
				writeln('la cantidad fue: ',v[j].cantV);
			end;
		end;
	procedure ordenarV(var v:Vventas; dl:integer);
		var
			i,j,pos:integer; item:venta;
		begin
			for i:=1 to dl-1 do begin 
				pos:=i;
				for j:= i+1 to dl do 
					if(v[j].codigoP>v[pos].codigoP)then
						pos:=j;
				item:=v[pos];
				v[pos]:=v[i];
				v[i]:=item;
			end;
		end;
			
	procedure eliminarV(var v:Vventas; var dl:integer; x:integer; y:integer);
		function minDesde(v:Vventas; dl:integer; x:integer):integer;
			var
				i:integer;
			begin
				i:=1;
				while(v[i].codigoP<=x)and(i<dl)do 
					i:=i+1;
				if i>dl then
					minDesde:=0
					else
						minDesde:=i-1
				end;
		var
			i,corrimiento:integer;
		begin
			{para i que va desde la inf hasta sup contar cuantas posiciones son
			* 	dsp achicar la dl, pero moverlos antes }
	end;
	var
		V:Vventas; dl,x,y:integer;
	begin
		Randomize;
		dl:=0;
		cargarvalores(V,dl);
		ordenarV(V,dl);
		informarV(V,dl);
		writeln('primer codigo a eliminar: '); readln(x);
		writeln('segundo codigo a eliminar: '); readln(y);
		eliminarV(V,dl,x,y);
		informarV(V,dl);
	end.
