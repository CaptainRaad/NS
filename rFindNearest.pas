function TNodeSystem.rFindNearest(aNode: TNodeP; aDistance: Single; aPoint: TPointS; aIdx:Int64): TNodeP;
  var
		tmpNode:TNodeP;
		tmpDistance,minDistance:Single;
		I:Int64;
		Offset:TPointS;
	begin
    if aNode.SIdx <> aIdx then tmpNode := aNode;
		minDistance := aDistance;
		Offset.X := aNode.Pos.X - aPoint.X; Offset.Y := aNode.Pos.Y - aPoint.Y;
		tmpDistance := Hypot(Offset.X,Offset.Y);
    if tmpDistance < minDistance then
			begin
				tmpNode := aNode;
				minDistance := tmpDistance;
        aNode.SIdx := aIdx;
			end;

		for I := 0 to Length(aNode.Links) - 1 do
			begin
				if aNode.Links[I] <> nil then if aNode.Links[I].SIdx <> aIdx then
					begin
						Offset.X := aNode.Links[I].Pos.X - aPoint.X; Offset.Y := aNode.Links[I].Pos.Y - aPoint.Y;
						tmpDistance := Hypot(Offset.X, Offset.Y);
						if tmpDistance < minDistance then
							begin
								minDistance := tmpDistance;
								aNode.Links[I].SIdx := aIdx;
								tmpNode := rFindNearest(aNode.Links[I], minDistance, aPoint, aIdx);
							end;
					end;
			end;
		rFindNearest := tmpNode;
	end;
