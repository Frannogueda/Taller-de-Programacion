program ejercicio; 
	const
		ele=30;
		rublo=8;
	type
		Rrublo=1..rublo;
		producto=record
			codigoP:integer;
			codigoR:Rrublo;
			precio:real;
		end;
		lista=^nodo;
		nodo=record
			dato:producto;
			sig:lista;
		end;
		Vlibreria=array[Rrublo]of lista;
		V3=array[1..ele]of producto;
	
	procedure inicializarV(var v:Vlibreria);
		var
			i:integer;
		begin
			for i:=1 to 8 do v[i]:=nil;
		end;
	procedure leerProducto(var p:producto);
		begin
			writeln('ingrese el precio del producto: '); readln(p.precio);
			if(p.precio<>0)then begin
				writeln('ingrese el codigo del producto: '); readln(p.codigoP);
				writeln('ingrese el codigo del rublo: '); readln(p.codigoR);
			end;
		end;
	procedure crearOrdenado(var l:lista; p:producto);
		var
			aux,act,ant:lista;
		begin
			new(aux);
			aux^.dato:=p;
			act:=l;
			ant:=l;
			while(act<>nil)and(p.codigoP>act^.dato.codigoP)do begin
				ant:=act;
				act:=act^.sig;
			end;
		if(act=ant)then
			l:=aux
			else
				ant^.sig:=aux;
			aux^.sig:=act;
		end;
			
	procedure cargardatos(var v:Vlibreria);
		var
			p:producto;
		begin
			leerProducto(p);
			while(p.precio<>0)do begin
				crearOrdenado(v[p.codigoR],p);
				leerProducto(p);
			end;
		end;
	procedure informaDatos(v:Vlibreria);
		var
			i:integer;
		begin
			for i:=1 to 8 do begin
				while(v[i]<>nil)do begin
					writeln('el rublo ',i,' los codigos fueron: ',v[i]^.dato.codigoP);
					v[i]:=v[i]^.sig;
				end;
			end;
		end;
	procedure rublo_3(l:lista; var v:v3; var dl:integer);
		var
			i:integer;
		begin
			i:=1;
			while(l<>nil)and(i<ele)do begin
				v[i]:=l^.dato;
				i:=i+1;
				l:=l^.sig;
			end;
			dl:=i;
		end;
	procedure OrdenarV(var v:v3; dl:integer);
		var
			i,j,pos:integer; item:producto;
		begin
			for i:=1 to dl-1 do begin
				pos:=i;
				for j:=i+1 to dl do 
					if(v[j].precio>v[i].precio)then
						pos:=j;
				item:=v[pos];
				v[pos]:=v[i];
				v[i]:=item;
			end;
		end;
		
	procedure informarRubli(v:v3; dl:integer);
		var
			i:integer;
		begin
			for i:=1 to dl do 
				writeln('el precio en la posicion ',i,' es: ',v[i].precio);
		end;
	procedure promedios(v:v3; dl:integer);
		var
			i:integer; cant,prom:real;
		begin
			cant:=0; prom:=0;
			for i:=1 to dl do 
				cant:=v[i].precio+cant;
			prom:=cant/dl;
			writeln('el promedio del vector es: ',prom);
		end;
					
	var
		v:Vlibreria; rublito:V3; dl:integer;
	begin
		inicializarV(v);
		cargardatos(v);{inciso A}
		informaDatos(v);{inciso B}
		rublo_3(v[3],rublito,dl);{inciso C}
		OrdenarV(rublito,dl);{inciso D}
		informarRubli(rublito,dl);{inciso E}
		promedios(rublito,dl);{inciso F}
	end.
