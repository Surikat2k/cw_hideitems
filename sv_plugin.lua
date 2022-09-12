local PLUGIN = PLUGIN;

function PLUGIN:Think()
	for itemID, entityID in pairs(Clockwork.item.entities) do

		local itemEntity = Clockwork.item:FindInstance(itemID);
		local dist;
		local checkDist;

		if (!entityID.RealPos) then
			entityID.RealPos = entityID:GetPos();
            entityID:SetNWVector("realPosNW", entityID:GetPos())
		else

			if (itemEntity.category == "Артефакты") then
				dist = 128;
			else
				dist = 1024;
			end;

			if (!entityID.Shared) then
                entityID:GetPhysicsObject():Sleep();
				entityID:SetNoDraw(true);
				entityID:SetPos(Vector(0, 0, -1000));
			end;

			local plyTable = {};

			local sphereTable = ents.FindInSphere(entityID.RealPos, dist)
            for _, ply in pairs(sphereTable) do
				if ply:IsPlayer() then
					table.insert(plyTable, ply);
				end;
            end;
			for _, ply in pairs(sphereTable) do

				if (#plyTable != 0) then
		        	if (entityID.Shared) then
						entityID.RealPos = entityID:GetPos();
                        entityID:SetNWVector("realPosNW", entityID:GetPos())
		        	else
			        	entityID:SetPos(entityID.RealPos);
            			entityID:GetPhysicsObject():Wake();
			        	entityID:SetNoDraw(false);
			        	entityID.Shared = true;
					end
				else
					entityID:SetNoDraw(true);
            		entityID:GetPhysicsObject():Sleep();
					entityID:SetPos(Vector(0, 0, -1000));
			        entityID.Shared = false;
				end;
		    end;
		end;
	end;
end;