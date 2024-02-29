{cuando dice que una estructura sea eficiente es un arbol}
program eje;
	type
		venta=record
			codigoP:integer;
			fecha:integer;
			cantV:integer;
		end;
		arbol=^nodo;
		nodo=record
			dato:venta;
			HD:arbol;
			HI:arbol;
		end;
	procedure cargarDatos(var priA:arbol; var segA:arbol);
		procedure leerVenta(var v:venta);
			begin
				readln(v.codigoP);
				if(v.codigoP<>0)then begin
					v.fecha:=random(30);
					v.cantV:=random(200);
				end;
			end;
		procedure crearArbol(var a:arbol; v:venta);
			begin
				if(a=nil)then begin
					new(a);
					a^.dato:=v;
					a^.HD:=nil;
					a^.HI:=nil;
				end
				else
					if(v.codigoP>a^.dato.codigoP)then
						crearArbol(a^.HD,v)
						else
							crearArbol(a^.HI,v);
			end;
		procedure crearArbol2(var a:arbol; v:venta);
			begin
				if(a=nil)then begin
					new(a);
					a^.dato:=v;
					a^.HD:=nil;
					a^.HI:=nil;
				end
				else
					begin
					if(v.codigoP=a^.dato.codigoP)then 
						a^.dato.cantV:=a^.dato.cantV+v.cantV
						else
							if(v.codigoP>a^.dato.codigoP)then
								crearArbol(a^.HD,v)
							else
								crearArbol(a^.HI,v);
					end;				
			end;
		var
			v:venta;
		begin
			leerVenta(v);
			while(v.codigoP<>0)do begin
				crearArbol(priA,v);
				crearArbol2(segA,v);
				leerVenta(v);
				end;
		end;
	function busqueda(a:arbol; num:integer):integer;
		begin
			if(a<>nil)then begin
				if(a^.dato.codigoP=num)then
					busqueda:=a^.dato.cantV
					else
						if(a^.dato.codigoP<num)then
							busqueda(a^.HD,num)
							else
								busqueda(a^.HI,num);
			end;
		end;
	var
		priA:arbol; SegA:arbol; num:integer;
	begin
		priA:=nil; segA:=nil;
		randomize;
		cargarDatos(priA,segA);{Inciso A}
		writeln('ingresa el valor que buscar en el primer arbol: '); readln(num);
		writeln('la cantidad vendida fue: ',busqueda(priA,num)); {Inciso B}{cuestionable}
		writeln('ingresa el valor que buscar en el segundo arbol: '); readln(num);
		writeln('la cantidad vendida fue: ',busqueda(segA,num));{Inciso C}
	end.
