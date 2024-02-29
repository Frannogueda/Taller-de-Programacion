program eje;
	const
		df=20;
	type
		numeros=array[1..df]of integer;
	procedure cargarV(var v:numeros);
		var
			i:integer; num:integer;
		begin
			for i:= 1 to df do begin
				num:=random(99);
				v[i]:=num;
			end;
		end;
	procedure OrdenacionV(var v:numeros);
		var
			i,j:integer; actual:integer;
		begin
			for i:= 2 to df do begin
				actual:=v[i];
				j:=i-1;
				while(j>0)and(v[j]>actual)do begin
					v[j+1]:=v[j];
					j:=j-1;
				end;
				v[j+1]:=actual;
			end;
		end;
	procedure informarV(v:numeros);
		var
			i:integer;
		begin
			for i:=1 to df do 
				writeln(v[i]);
			end;
	Procedure busquedaDicotomica (v:numeros; ini,fin:integer; dato:integer; var pos:integer);
		var
			medio:integer; encontrado:boolean;
		begin
			encontrado:=false;
			while(ini<fin)and (not encontrado)do begin
				medio:=ini+fin div 2;
				if(v[medio]=dato)then
					encontrado:=true
				else
					if(v[medio]<dato)then
						ini:=ini+1
						else
							fin:=fin-1;
					end;
				if(encontrado)then
					pos:=medio
					else
						pos:=-1;
				end;
	
	var
		v:numeros; ini,fin,dato,pos:integer;
	begin
		randomize;
		ini:=1; fin:=df;
		cargarV(v);
		OrdenacionV(v);
		informarV(v);
		writeln('ingresa el dato a buscar en el vector: '); readln(dato);
		busquedaDicotomica(v,ini,fin,dato,pos);
		if(pos=-1)then
			writeln('el dato no se encontro en el vector')
			else
				writeln('el ',dato,' fue encontrado en la posicion: ',pos);
	end.
