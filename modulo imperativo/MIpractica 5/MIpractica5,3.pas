program eje;
	type
		RangoR=1..10;
		producto=record
			codigo:integer;
			rublo:RangoR;
			stock:integer;
			precioU:integer;
		end;
		arbol=^nodo;
		nodo=record
			dato:producto;
			HI:arbol;
			HD:arbol;
		end;
		Vrublos=array[RangoR]of arbol;
		VrublosMax=array[RangoR]of arbol;
		Vcontador=array[RangoR]of integer;
	procedure cargarDatos(var v:Vrublos);
		procedure InicializarV(var v:Vrublos);
			var
				i:integer;
			begin
				for i:=1 to 10 do 
					v[i]:=nil;
			end;
		procedure LeerProducto(var p:producto);
			begin
				writeln('ingrese el codigo: '); readln(p.codigo);
				if(p.codigo<>-1)then begin
					p.rublo:=random(10);
					p.stock:=random(200);
					p.precioU:=random(300);
				end;
			end;
		procedure crearArbol(var a:arbol; p:producto);
			begin
				if(a=nil)then begin
					new(a);
					a^.dato:=p;
					a^.HD:=nil;
					a^.HI:=nil;
				end
					else
						if(a^.dato.codigo>=p.codigo)then
							crearArbol(a^.HI,p)
							else
								crearArbol(a^.HD,p)
					
			end;
		var
			p:producto;
		begin
			InicializarV(v);
			LeerProducto(p);
			while(p.codigo<>-1)do begin
				crearArbol(v[p.rublo],p);
				LeerProducto(p);
			end;
		end;
	function BusquedaRB(a:arbol; codigoB:integer):boolean;
		begin
			if(a=nil)then 
				BusquedaRB:=false
				else
					if(a^.dato.codigo=codigoB)then
						BusquedaRB:=true
						else
							if(a^.dato.codigo>codigoB)then
								BusquedaRB:=BusquedaRB(a^.HI,codigoB)
								else
									BusquedaRB:=BusquedaRB(a^.HD,codigoB)
		end;
	procedure LosMaximosV(v:Vrublos; var vMax:VrublosMax);
		function Maximo(a:arbol):arbol;
			begin
				if(a=nil)then
					Maximo:=nil
					else
						if(a^.HD=nil)then
							Maximo:=a
						else
							Maximo:=Maximo(a^.HD)
				end;
		var
			i:integer; 
		begin
			for i:=1 to 10 do begin
				vMax[i]:=Maximo(v[i]);
			end;
		end;
	procedure ContadorRCodigos(v:Vrublos; var vCont:Vcontador; c1,c2:integer);
		procedure inicializarCont(var v:Vcontador);	
			var
				i:integer;
			begin
				for i:= 1 to 10 do v[i]:=0;
			end;
		function ContarCodigo(a:arbol; c1,c2:integer):integer;
			begin
				if(a<>nil)then
					if(a^.dato.codigo>c1)then
						if(a^.dato.codigo<c2)then
							ContarCodigo:=1+ContarCodigo(a^.HD,c1,c2)+ContarCodigo(a^.HI,c1,c2)
						else
							ContarCodigo:=ContarCodigo(a^.HI,c1,c2)
					else
					ContarCodigo:=ContarCodigo(a^.HI,c1,c2)		
			end;
			
		var
			i:integer;
		begin
			inicializarCont(vCont);
			for i:=1 to 10 do 
				vCont[i]:=ContarCodigo(v[i],c1,c2);
		end;
	var
		v:Vrublos; CB,RB,code1,code2:integer; vMax:VrublosMax;
		vCont:Vcontador;
	begin
		randomize;
		cargarDatos(v);{Inciso A}
		writeln('seleccione el rublo en donde buscar el codigo: '); readln(RB);
		writeln('ingrese el codigo a buscar: ');readln(CB);
		if(BusquedaRB(v[RB],CB)=true)then{Inciso B}
			writeln('el codigo existe')
			else
				writeln('el codigo no existe');
		LosMaximosV(v,vMax);{Inciso C}
		writeln('ingrese el primer codigo como limite: '); readln(code1);
		writeln('ingrese el segundo: '); readln(code2);
		ContadorRCodigos(v,vCont,code1,code2);{Inciso D}
	end.
