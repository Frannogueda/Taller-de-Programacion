program ejercicio;
	const
		dimf=35;
	type
		Rnotas=1..dimf;
		vnotas=array[0..dimf]of integer;
		alumno=record 
			apellido:string;
			nroL:integer;
			anio:integer;
			cantMA:Rnotas;
			nota:vnotas;
		end;
	lista=^nodo;
	nodo=record
		dato:alumno;
		sig:lista;
		end;
		promedio=record
			alu:integer;
			prom:real;
		end;
		
	lista2=^Nnodo;
	Nnodo=record
		dato:promedio;
		sig:lista2;
	end;
		
	procedure nuevoNodo(var L: lista; A:alumno);
		var 
			nue: lista;
		begin
			new (nue);
			nue^.dato:= A;
			nue^.sig := L;
			L:=nue;
		end;
		
	procedure iniVecNotas(var V: vnotas);
		var
			i: integer;
		begin
			for i:=0 to dimF do begin
				V[i]:=0;
				end;
		end;
	
	procedure cargarNotas(var V: vnotas; dL: integer);
		var
			i: integer;
		begin
			for i:=1 to dL do begin
				writeln('Ingrese nota: ');
				readln(V[i]);
				end;
		end;
	
	procedure agregarAlumnos(var A: alumno);
		begin
			with A do begin
				writeln('apellido: '); readln(apellido);
				writeln('nro alu: '); readln(nroL);
				writeln('anio: '); readln(anio);
				writeln('cantidad de materias: '); readln(cantMA);
				iniVecNotas(nota);
				cargarNotas(nota,cantMA);
			end;
		end;
	
	procedure crearlista(var l:lista);
		var
			a:alumno;
		begin
			repeat 
				agregarAlumnos(a);
				nuevoNodo(l,a);
			until(a.nroL=11111)
		end;
	function prome(num:integer; nota:vnotas):real;
		var
			i,notitas:integer;
		begin
			notitas:=0;
			for i:=1 to num do
				notitas:=nota[i]+notitas;
			prome:=notitas/num;
		end;
	procedure crearjugador(var l2:lista2; nro:integer; p:real);
		var
			aux:lista2;
		begin
			new(aux);
			aux^.dato.alu:=nro;
			aux^.dato.prom:=p;
			aux^.sig:=l2;
			l2:=aux;
		end;
		
			
	procedure crearlistaAlu(var l:lista2; nro:integer; materias:integer; nota:vnotas);
		var
			cant:real;
		begin
			cant:=prome(materias,nota);
			crearjugador(l,nro,cant);
		end;
		
	procedure informaAlumnos(l:lista; var l2:lista2);
		begin
			while(l<>nil)do begin
				crearlistaAlu(l2, l^.dato.nroL,l^.dato.cantMA, l^.dato.nota);
				l:=l^.sig;
			end;
		end;
	procedure informar(l:lista2);
		begin
			while(l<>nil)do begin
				writeln('el alumno: ',l^.dato.alu,'y su promedio es: ',l^.dato.prom);
				l:=l^.sig;
			end;
		end;
	var
		l:lista; l2:lista2;
	begin
		l:=nil; l2:=nil;
		crearlista(l);
		informaAlumnos(l,l2);
		informar(l2);
		end.
	
