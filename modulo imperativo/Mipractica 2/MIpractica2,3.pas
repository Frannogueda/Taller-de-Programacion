program eje;
	type
		lista=^nodo;
		nodo=record
			dato:integer;
			sig:lista;
		end;
	procedure cargardatos(var l:lista; num:integer);
		procedure crearNodo(var l:lista; num:integer);
			 var
				nue, temp: lista;
			begin
				new(nue);
				nue^.dato := num;
				nue^.sig := nil;
			if l = nil then
				l := nue
			else begin
				temp := l;
            while temp^.sig <> nil do
                temp := temp^.sig;
            temp^.sig := nue;
        end;
       end;
		begin
			if(num<>0)then begin
				crearNodo(l,num);
				num:=random(99);
				cargardatos(l,num);
			end;
		end;
	procedure informarL(l:lista);
		begin
			while(l<>nil)do begin
				writeln(l^.dato);
				l:=l^.sig;
			end;
		end;
	procedure minYmax(l:lista; var max,min:integer);
		begin
			if(l<>nil)then begin
				if(l^.dato>max)then
					max:=l^.dato;
				if(l^.dato<min)then
					min:=l^.dato;
				minYmax(l^.sig,max,min);
			end;
		end;
	function Busqueda(l:lista; x:integer):boolean;
		var
			encontro:boolean;
		begin
			encontro:=false;
			if(l=nil)then
				Busqueda:=encontro;
			if(l^.dato=x)then begin
				Busqueda:=true;
				encontro:=true;
			end
			else
				begin
					encontro:=Busqueda(l^.sig,x);
					Busqueda:=encontro;
				end;
		end;
	var
		l:lista; num,max,min,x:integer;
	begin
		l:=nil; max:=0; min:=110;
		Randomize;
		num:=random(99);
		cargardatos(l,num);{Inciso A}
		informarL(l);
		minYmax(l,max,min);{Inciso B y C}
		writeln('el maximo es: ',max,' y el minimo es: ',min);{B y C}
		writeln('ingrese el valor a buscar: '); readln(x);
		writeln('el valor fue: ',Busqueda(l,x));{Inciso D devuelve true si encontro o false si no encontro}
	end.
{inciso D tiene problemas al momento de no encontrar el valor}
