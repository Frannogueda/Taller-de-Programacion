program ejercicio2;
	type
		Rzona=1..5;
		Tpropiedad=record
			codigo:integer;
			tipo:string;
			precio:real;
		end;
		propiedad=record
			zona:Rzona;
			codigoP:integer;
			tipoP:string;
			cantM:integer;
			precioM:real;
		end;
		lista=^nodo;
		nodo=record
			dato:Tpropiedad;
			sig:lista;
		end;
		propiedades=array[Rzona]of Tpropiedad;
		
	procedure leerpropiedad(var p:propiedad);
		begin
			writeln('ingrese metro: '); readln(p.cantM);
			if(p.cantM<>-1)then begin
				writeln('zona: '); readln(p.zona); 
				writeln('codigo de la propiedad: '); readln(p.codigoP);
				writeln('tipo de propiedad: '); readln(p.tipoP);
				writeln('precio del metro: '); readln(p.precioM);
			end;
		end;
	procedure procesarPropiedad(p:propiedad; var t:Tpropiedad);
		begin
			t.codigo:=p.codigoP;
			t.tipo:=p.tipoP;
			t.precio:=p.cantM * p.precioM;
		end;
	procedure crearOrdenado(var l:lista; t:Tpropiedad);
		var
			aux,ant,act:lista;
		begin
			new(aux);
			aux^.dato:=t;
			act:=l;
			ant:=l;
			while(l<>nil)and(t.tipo>l^.dato.tipo)do begin
				ant:=act;
				act:=act^.sig;
				end;
			if(act=ant)then
				l:=aux
				else
					ant^.sig:=aux;
				aux^.sig:=act;
			end;

	procedure inicializarVlista(var v:propiedades);
		var
			i:integer;
		begin
			for i:= 1 to 5 do 
				v[i]:=nil;
			end;

	procedure crearlista(var v:propiedades);
		var
			p:propiedad; t:Tpropiedad;
		begin
			leerpropiedad(p);
			inicializarVlista(v);
			while(p.cantM<>-1)do begin
				procesarPropiedad(p,t);
				crearOrdenado(v[p.zona],t);
				leerpropiedad(p);
			end;
		end;
	var
		v:propiedades;
	begin
		crearlista(v);
	end.
		
