function TNodeSystem.rFindNearest(aNode: TNodeP; aDistance: Single; aPoint: TPointS; aIDX: Int64): TNodeP;
  var
		tmpNode:TNodeP;
		tmpDistance,minDistance:Single;
		I:Int64;
		Offset:TPointS;
	begin
    tmpNode := aNode;
    minDistance:= aDistance;
    if aNode.sIDX <> aIDX then
      begin
        minDistance := aDistance;
        Offset.X := aNode.pos.X - aPoint.X; Offset.Y := aNode.pos.Y - aPoint.Y;
        tmpDistance := Hypot(Offset.X, Offset.Y);
          if tmpDistance < minDistance then
            begin
              tmpNode := aNode;
              minDistance := tmpDistance;
              aNode.sIDX := aIDX;
            end;
      end;
    for I := 0 to Length(aNode.links) - 1 do
      begin
        if aNode.links[I] <> nil then if aNode.links[I].sIDX <> aIDX then
          begin
            Offset.X := aNode.Links[I].pos.X - aPoint.X; Offset.Y := aNode.Links[I].pos.Y - aPoint.Y;
            tmpDistance := Hypot(Offset.X, Offset.Y);
            if tmpDistance < minDistance then
              begin
                tmpNode := aNode.links[I];
                minDistance := tmpDistance;
                aNode.links[I].sIDX := aIDX;
                tmpNode := rFindNearest(tmpNode,minDistance, aPoint, aIDX);
              end;
          end;
      end;
    rFindNearest := tmpNode;
	end;
