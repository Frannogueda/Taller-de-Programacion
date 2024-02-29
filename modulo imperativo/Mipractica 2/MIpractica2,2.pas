program eje;
	type 
		lista=^nodo;
		nodo=record
			dato:integer;
			sig:lista;
		end;
	procedure cargarL(var l:lista);
		procedure crearNodo(var l: lista; num: integer);
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
		var
			num:integer;
		begin
			writeln('ingrese un numero: '); readln(num);
			if(num<>0)then begin
				crearNodo(l,num);
				cargarL(l);
			end;
		end;
	procedure informarL(l:lista);
		procedure informardig(num:integer);
			var
				dig:integer;
			begin
				while(num<>0)do begin
					dig:=num mod 10;
					writeln('el digito es: ',dig);
					num:=num div 10;
				end;
			end;
		begin
			if(l<>nil)then begin
				informarL(l^.sig);
				informardig(l^.dato);
			end;
		end;
	var
		l:lista;
	begin
		l:=nil;
		cargarL(l);
		informarL(l);
	end.
