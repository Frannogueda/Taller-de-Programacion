program eje;
	const 
		materias=30;
	type
		Rango=1..10;
		Vnotas=array[1..materias]of Rango;
		alumno=record
			CodigoAlumno:integer;
			nota:Vnotas;
		end;
		arbol=^nodo;
		nodo=record
			dato:alumno;
			HI:arbol;
			HD:arbol;
		end;
	procedure cargarPrimerArbol(var a:arbol);
		procedure leerAlumno(var alu:alumno);
			var
				i:integer;
			begin
				i:=1;
				readln(alu.CodigoAlumno);
				readln(alu.nota[i]);
				while(alu.nota[i]<>-1)and(i<=materias)do begin
					i:=i+1;
					readln(alu.nota[i]);
				end;	
			end;
		function chequeo(v:Vnotas):integer;
			var
				pos:integer;
			begin
				pos:=1;
				while(pos<=materias)do begin
					if(v[pos]>0)then
						pos:=pos+1
					else
						chequeo:=-1
				end;
				chequeo:=0;
			end;
		procedure crearArbol(var a:arbol; alu:alumno);
			begin
				if(a=nil)then begin
					a^.dato:=alu;
					a^.HI:=nil;
					a^.HD:=nil;
				end
					else
						if(a^.dato.CodigoAlumno>alu.CodigoAlumno)then
							crearArbol(a^.HI,alu)
							else
								crearArbol(a^.HD,alu);
			end;
		var
			alu:alumno; aux:integer;
		begin
			leerAlumno(alu);
			aux:=chequeo(alu.nota);
			while(aux<>-1)do begin
				crearArbol(a,alu);
				leerAlumno(alu);
				end;
		end;
	var
		a:arbol;
	begin
		cargarPrimerArbol(a);{cortar con codigo de materia? o alumno}
	end.
