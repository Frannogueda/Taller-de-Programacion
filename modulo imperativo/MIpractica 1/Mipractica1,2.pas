program ejercicio;
	const
		df=300;
	type
		oficina=record
			codigoI:integer;
			dni:integer;
			valor:real;
			end;
		Voficinas=array[1..df]of oficina;
		
	procedure leerOficina(var o:oficina);
		begin
			with o do begin
				writeln('codigo de empreado: '); readln(codigoI);
				if(codigoI<>-1)then begin
					writeln('dni del propietario: '); readln(dni);
					writeln('el valor de la empresa es: '); readln(valor);
					end;
				end;
		end;
	procedure cargarvalores(var v:Voficinas; var dl:integer);
		var
			i:integer; o:oficina;
		begin
			leerOficina(o);
			i:=1;
			while(o.codigoI<>-1)and(i<df)do begin
				v[i]:=o;
				i:=i+1;
				leerOficina(o);
				end;
			dl:=i;
		end;
	procedure ordenarV(var v:Voficinas; dl:integer);
		var
			i,j,pos:integer; item:oficina;
		begin
			for i:= 1 to dl-1 do begin
				pos:=i;
				for j:= i+1 to dl do 
					if(v[j].codigoI<v[pos].codigoI)then
						pos:=j;
				item:=v[pos];
				v[pos]:=v[i];
				v[i]:=item;
			end;
		end;
	procedure informarV(v:Voficinas; dl:integer);
		var
			i:integer;
		begin
			for i:=1 to dl do begin
				writeln('el codigo fue: ',v[i].codigoI);
				writeln('el dni fue: ',v[i].dni);
				writeln('el valor total de la empresa fue: ',v[i].valor);
			end;
		end;
	var
		V:Voficinas; dl:integer;
	begin
		cargarvalores(V,dl);
		ordenarV(V,dl);
		
		informarV(V,dl);
	end.
