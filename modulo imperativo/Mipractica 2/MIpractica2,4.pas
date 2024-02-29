program eje;
	const 
		df=20;
	type
		numeros=array[1..df]of integer;
	procedure cargarV(var v:numeros; var dl:integer);
		var
			num:integer;
		begin
			if(dl<df)then begin
				num:=random(99);{consultar como hacer para que sea mayor que 0}
				v[dl]:=num;
				dl:=dl+1;
				cargarV(v,dl);
			end;
		end;			
	procedure informar(v:numeros; dl:integer);
		var
			i:integer;
		begin
			for i:=1 to dl do 
				writeln('el valor en la posicion: ',i,' es: ',v[i]);
		end;
	procedure Maximo(v:numeros; dl:integer; var max:integer);
		begin
			if(dl>0)then begin
				if(v[dl]>max) then
					max:=v[dl];
				Maximo(v,dl-1,max);
			end;
		end;
	procedure sumaV(v:numeros; dl:integer; var suma:integer);
		begin
			if(dl>0)then begin
				suma:=suma+v[dl];
				sumaV(v,dl-1,suma);
			end;
		end;
	var
		v:numeros; dl:integer; max,suma:integer;
	begin
		dl:=1; max:=-1; suma:=0;
		Randomize;
		cargarV(v,dl);{Inciso A}
		informar(v,dl);
		Maximo(v,dl,max);{Inciso B}
		writeln('el maximo del vector fue: ',max);
		sumaV(v,dl,suma);{Inciso C}
		writeln('la suma de todo el vector fue: ',suma);
	end.
