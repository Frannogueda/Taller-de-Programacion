program ejercicio;
	type
		producto= record
			codigoVentaP:integer;
			cantTV:integer;
			montoT:real;
		end;
		venta=record
			codigoV:integer;
			codigoVP:integer;
			cantUV:integer;
			precio:real;
			{multiplicar cantUV por precio}
		end;
		arbol=^nodo;
		nodo=record
			dato:producto;
			HD:arbol;
			HI:arbol;
		end;
	procedure leerventa(var v:venta);
		begin
			writeln('ingrese el codigo de venta: ');readln(v.codigoV);
			if(v.codigoV<>-1)then begin
				v.codigoVP:=random(200);
				v.cantUV:=random(500);
				v.precio:=random(1000);
			end;
		end;
	procedure crearArbol(var a:arbol; v:venta);
		procedure convertir(v:venta; var p:producto);
			begin
				p.codigoVentaP:=v.codigoVP;
				p.montoT:=v.cantUV * v.precio;
				p.cantTV:=v.cantUV;
			end;
		var
			p:producto;
		begin
			if(a=NIl)then begin
				new(a);
				convertir(v,p);
				a^.dato:=p;
				a^.HD:=nil;
				a^.HI:=nil;
				end
				else
					if(a^.dato.codigoVentaP = v.codigoVP)then begin
						a^.dato.montoT:= a^.dato.montoT+(v.cantUV*v.precio);
						a^.dato.cantTV:=a^.dato.cantTV+v.cantUV;
					end
						else
							if(a^.dato.codigoVentaP<v.codigoVP)then
								crearArbol(a^.HI,v)
							else
								crearArbol(a^.HD,v);
							end;
	procedure cargarvalores(var a:arbol);
		var
			v:venta;
		begin
			a:=nil;
			leerventa(v);
			while(v.codigoV<>-1)do begin
				crearArbol(a,v);
				leerventa(v);
			end;
		end;
	procedure ImprimirArbol(a:arbol);
		begin
			if(a<>nil)then begin
				ImprimirArbol(a^.HI);
				writeln('el codigo es: ',a^.dato.codigoVentaP);
				ImprimirArbol(a^.HD);
			end;
		end;
	procedure MayorUnidades(a:arbol; var codigoMax:integer; var cantUM:integer);
		begin
			if(a<>nil)then begin
				MayorUnidades(a^.HI,codigoMax,cantUM);
				MayorUnidades(a^.HD,codigoMax,cantUM);
				if(a^.dato.cantTV>cantUM)then begin
					codigoMax:=a^.dato.codigoVentaP;
					cantUM:=a^.dato.cantTV;
				end;
			end;
		end;
	procedure CodigosMenores(a:arbol; var codeB:integer; var cantC:integer);
		begin
			if(a<>nil)then begin
				if(a^.dato.codigoVentaP<codeB)then
					cantC:=cantC+1;
				CodigosMenores(a^.HI,codeB,cantC);
				CodigosMenores(a^.HD,codeB,cantC);
				
			end;
		end;
	function MontoTotal(a:arbol; code1,code2:integer):real;
		begin
			if(a<>nil)then
				if(a^.dato.codigoVentaP>code1)then
					if(a^.dato.codigoVentaP<code2)then
						MontoTotal:=a^.dato.montoT+MontoTotal(a^.HI,code1,code2)+MontoTotal(a^.HD,code1,code2)
					else
						MontoTotal:=MontoTotal(a^.HI,code1,code2)
				else
					MontoTotal:=MontoTotal(a^.HD,code1,code2)
		end;
	
	var
		a:arbol; codigoMax,cantUM:integer;
		codeB,cantC,code1,code2:integer;
	begin
		randomize;
		codigoMax:=0; cantUM:=0; cantC:=0; 
		cargarvalores(a);{Inciso A}
		ImprimirArbol(a);{Inciso B}
		MayorUnidades(a,codigoMax,cantUM);{Inciso C}
		writeln('el codigo: ',codigoMax,' fue el que tuvo mas unidades vendidas que fueron: ',cantUM);
		writeln('codigo a buscar para que sea menor: '); readln(codeB);
		CodigosMenores(a,codeB,cantC);{Inciso D}
		writeln('hay: ',cantC,' menores que ',codeB);
		writeln('primer codigo para poner: '); readln(code1);
		writeln('segundo codigo para limitar: '); readln(code2);
		writeln('el monto total entre los dos codigos es: ',MontoTotal(a,code1,code2));{Inciso D}
		{nose si esta bien el ultimo Inciso}
	end.
