program ejercicio;
	type
		Genero=1..8;
		pelicula=record 
			codigoP:integer;
			codigoG:Genero;
			puntaje:integer;
		end;
		mejorP=record
			peli:integer;
			nota:integer;
		end;
		lista=^nodo;
		nodo=record
			dato:pelicula;
			sig:lista;
			end;
		Vgeneros=array[Genero] of lista;
		Vmejor=array[Genero] of mejorP;
	procedure leerpeli(var p:pelicula);
		begin
			writeln('ingrese el codigo de la pelicula: '); readln(p.codigoP);
			writeln('ingresar el genero de la pelicula'); readln(p.codigoG);
			writeln('ingresar el puntaje obtenido de la pelicula'); readln(p.puntaje);
		end;
	procedure crearAtras(var l:lista; var ult:lista; p:pelicula);
		var
			aux:lista;
		begin
			new(aux);
			aux^.dato:=p;
			aux^.sig:=nil;
			if(l=nil)then
				l:=aux
			else
				ult^.sig:=aux;
			ult:=aux;
		end;
	
	procedure cargardatosL(var v:Vgeneros);
		var
			p:pelicula; ult:lista;
		begin
			leerpeli(p);
			while(p.codigoP<>-1)do begin
				crearAtras(v[p.codigoG],ult,p);
				leerpeli(p);
			end;
		end;
	procedure inicializarVL(var v:Vgeneros);
		var
			i:Genero;
		begin
			for i:=1 to 8 do 
				v[i]:=nil;
			end;
	procedure Maxs(v:Vgeneros; var peli:Vmejor);
		var
			i,max:integer; 
		begin
			for i:=1 to 8 do begin
				max:=0; 
				while(v[i]<>nil)do begin
					if (v[i]^.dato.puntaje>max)then begin
						peli[i].peli:=v[i]^.dato.codigoP;
						peli[i].nota:=v[i]^.dato.puntaje;
					end;
					{agregar para informar el minimo}
					v[i]:=v[i]^.sig;
				end;
			end;
		end;
	procedure ordenarV(var v:Vmejor);
		var
			i,j,pos:integer; item:mejorP;
		begin
			for i:=1 to 8-1 do begin
				pos:=1;
				for j:=i+1 to 8 do
					if(v[j].nota>v[pos].nota)then
						pos:=j;
				item:=v[pos];
				v[pos]:=v[i];
				v[i]:=item;
			end;
		end;
	procedure informarV(v:Vmejor);
		var
			i:integer;
		begin
			for i:=1 to 8 do 
				writeln('el codigo de la mejor peli en la posicion: ',i,' fue: ',v[i].peli,' y su puntaje fue: ',v[i].nota);
			end;
	var
		v:Vgeneros; peli:Vmejor;
	begin
		inicializarVL(v);
		cargardatosL(v);
		Maxs(v,peli);
		ordenarV(peli);
		informarV(peli);
	end.
