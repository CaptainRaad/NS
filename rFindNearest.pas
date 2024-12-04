function TNodeSystem.rFindNearest(aNode: TNodeP; aDistance: Single; aPoint: TPointS): TNodeP;
  var
		tmpNode:TNodeP;
		tmpDistance,minDistance:Single;
		I:Int64;
		Offset:TPointS;
	begin
		minDistance := aDistance;
		Offset.X := aNode.Pos.X - aPoint.X; Offset.Y := aNode.Pos.Y - aPoint.Y;
		tmpDistance := Hypot(Offset.X,Offset.Y);

		if tmpDistance < minDistance then
			begin
				tmpNode := aNode;
				minDistance := tmpDistance;
			end;

		aNode.Find := not aNode.Find;

		for I := 0 to Length(aNode.Links) - 1 do
			begin
				if aNode.Links[I] <> nil then if aNode.Links[I].Find <> aNode.find then
					begin
						Offset.X := aNode.Links[I].Pos.X; Offset.Y := aNode.Links[I].Pos.Y;
						tmpDistance := Hypot(Offset.X, Offset.Y);
						if tmpDistance < minDistance then
							begin
								minDistance := tmpDistance;
								aNode.Links[I].Find := not aNode.Links[I].Find;
								tmpNode := rFindNearest(aNode.Links[I], minDistance, aPoint);
							end;
					end;
			end;
		rFindNearest := tmpNode;
	end;
