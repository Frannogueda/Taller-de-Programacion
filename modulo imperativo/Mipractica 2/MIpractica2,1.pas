program recu;
	const 
		df=10;
	type 
		dato=array[1..df]of char;
		lista=^nodo;
		nodo=record 
			dato:char;
			sig:lista;
		end;
	
	procedure cargarDato(var v:dato; var dl:integer);{Inciso A}
		var
			c:char;
		begin
			writeln('ingresar caracter: '); readln(c);
			if(c<>'.')and(dl<10)then begin
				dl:=dl+1;
				v[dl]:=c;
				cargarDato(v,dl);
			end;
		end;
		
	procedure informar(v:dato; dl:integer);{Inciso B}
		var
			i:integer;
		begin
			for i:= 1 to dl do
				writeln('el caracter fue: ',v[i])
			end;
	
	procedure informarRecu(v:dato; dl:integer; var cant:integer);{Inciso C}
		begin
			if(dl<>0)then begin
				writeln('el valor es: ',v[dl]);
				dl:=dl-1;
				cant:=cant+1;{sume en cant la cantidad de caracteres ingresados, Inciso D}
				informarRecu(v,dl,cant);
			end
		end;
	procedure cargarLista( var l:lista; c:char);
		procedure crearNodo(var l:lista; c:char);
			var
				aux:lista;
			begin
				new(aux);
				aux^.dato:=c;
				aux^.sig:=nil;
				l:=aux;
			end;
			
		var
			cha:char;
		begin
			writeln('ingresa el carac: '); readln(cha);
			if(cha<>'.')then begin
				crearNodo(l,cha);
				cargarLista(l^.sig,cha);
			end;
		end;
	procedure informarLRecuM(l:lista);
		begin
			if(l<>nil)then begin
				writeln('el caracter fue: ',l^.dato);
				informarLRecuM(l^.sig);
			end;
		end;
	procedure informarLRecuI(l:lista);
		begin
			if(l<>nil)then begin
				informarLRecuI(l^.sig);
				writeln('los caracteres fueron: ',l^.dato);
			end;
		end;
	var
		v:dato; i,cant:integer; l:lista; 
	begin
		i:=0; cant:=0; l:=nil; 
		cargarDato(v,i);
		informar(v,i);
		informarRecu(v,i,cant);
		cargarLista(l,' ');{Inciso E}
		informarLRecuM(l);{Inciso F}
		informarLRecuI(l);{Inciso G}
		writeln('la cantidad de caracteres son: ',cant);{Inciso D}
	end.
