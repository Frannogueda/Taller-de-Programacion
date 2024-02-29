program eje;
	const 
		df=300;
	type
		oficina=record
			codigoI:integer;
			dniP:integer;
			valorE:real;
		end;
		Voficinas=array[1..df]of oficina;
	procedure cargarDatos(var v:Voficinas; var dl:integer);
		procedure leerOficina(var o:oficina);
			begin
				readln(o.codigoI);
				if(o.codigoI<>-1)then begin
					readln(o.dniP);
					readln(o.valorE);
				end;
			end;
		var
			o:oficina; pos:integer;
		begin
			pos:=1;
			leerOficina(o);
			while(pos<df)and(o.codigoI<>-1)do begin
				v[pos]:=o;
				pos:=pos+1;
			end;
			dl:=pos;
		end;
	procedure ordenarV(var v:Voficinas; dl:integer);
		var
			i,j,pos:integer; item:oficina;
		begin
			for i:=1 to dl-1 do begin
				pos:=i;
				for j:=i+1 to dl do begin
					if(v[j].codigoI<v[pos].codigoI)then
						pos:=j;
				item:=v[pos];
				v[pos]:=v[i];
				v[i]:=item;
				end;
			end;
		end;
	var
		v:Voficinas; dl:integer;
	begin
		cargarDatos(v,dl);
		ordenarV(v,dl);
		{completar los incisos restantes}
	end.
