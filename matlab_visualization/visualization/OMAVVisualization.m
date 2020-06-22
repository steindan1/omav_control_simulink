% Copyright (C) 2017  Marco Hutter, Christian Gehring, C. Dario Bellicoso,
% Vassilios Tsounis
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

% CLASSDEF obj = OMAVVisualization()
%
% -> generates a visualization of the OMAV consisting of base and 6 moving
% links
%
% obj.load(), obj.load(fig_handle)
% -> loads the patchSets in its actual configuration in the figure
%
% obj.updat(q)
% with: * q_new = [q1,q2,q3,q4,q5,q6]  generalized joint coordinates [rad]
% -> updates the structure to the new joint angles
%

% Modified by Daniel Steinmann to be used with a hexacopter

classdef OMAVVisualization < handle

    properties

        % Figure and Axes
        vizFig_
        vizAx_

        % Visualization elements
        tfs_
        links_
        frames_
        omegaVecs_
        rotorMaxVecs_

        % start configuration
        rotCenterPoint_
        rotAxis_
        Iorigin_

    end

    methods

        function obj = OMAVVisualization()

            mat.FaceColor = [210,112,16]/255;
            mat.EdgeColor = 'none';
            mat.AmbientStrength = 0.3;
            mat.DiffuseStrength = 0.3;
            mat.SpecularStrength = 1;
            mat.SpecularExponent = 25;
            mat.SpecularColorReflectance = 0.5;

            % Define joint DoFs and patch offsets
            obj.rotCenterPoint_{1}=[0,0,0];
            obj.rotAxis_{1}=[1,0,0];
            obj.rotCenterPoint_{2}=[0,0,0];
            obj.rotAxis_{2}=[1,0,0];
            obj.rotCenterPoint_{3}=[0,0,0];
            obj.rotAxis_{3}=[1,0,0];
            obj.rotCenterPoint_{4}=[0,0,0];
            obj.rotAxis_{4}=[1,0,0];
            obj.rotCenterPoint_{5}=[0,0,0];
            obj.rotAxis_{5}=[1,0,0];
            obj.rotCenterPoint_{6}=[0,0,0];
            obj.rotAxis_{6}=[1,0,0];

            % Generate patches with correct zero offsets
            %obj.links_{1} = genpatch('visualization/stl/base_omav.stl',mat,[0 0 0]);
            obj.links_{1} = genpatch('visualization/stl/base_omav.stl',mat,[0 0 0]);
            for i=1:6
                %obj.links_{i+1} = genpatch(['visualization/stl/link',num2str(i),'.stl'],mat,obj.rotCenterPoint_{i});
                obj.links_{i+1} = genpatch(['visualization/stl/rotor.stl'],mat,obj.rotCenterPoint_{i});
            end

        end

        function [] = reset(obj)
            for i=1:length(obj.links_)
                obj.links_{i}.reset();
            end
        end

        function [] = load(obj,scale,fontsize,Iorigin)

            % Create figure window and axes
            obj.vizFig_ = figure('Name','3D visualization OMAV','Position',[100 100 800 600],'NumberTitle', 'off');
            obj.vizAx_ = axes('parent', obj.vizFig_);
             set(obj.vizFig_,'Color',[1 1 1])
             set(obj.vizAx_,'Color',[1 1 1])
             axis(obj.vizAx_, 'equal');
             %axis(obj.vizAx_, 'vis3d');
             %axis(obj.vizAx_, 'off');
             %axis(obj.vizAx_, 'auto');

            % Fix view range
            viewscale = 0.4;
            viewlim3d = [-1 1 -1 1 -1 1];
            axis(obj.vizAx_, viewscale*viewlim3d);

            % Initialize body transforms for links which move
            NB = length(obj.links_);
            obj.tfs_ = cell(NB,1);
            obj.frames_ = cell(NB,1);

            % Set the graphics object hierarchy
            for i=1:NB
                obj.tfs_{i} = hgtransform('Parent', obj.vizAx_);
                set(obj.links_{i}.p_, 'Parent', obj.tfs_{i});
            end
            
            %set the patches to visible
            for i=1:NB
                obj.links_{i}.load();
            end
            
            %set base coordinate frame
            obj.frames_{1} = gencsframe(obj.vizAx_, 'B', scale, fontsize);
            for j=1:numel(obj.frames_{1})
                set(obj.frames_{1}{j}, 'parent', obj.tfs_{1});
            end
            
            %set desired coordinate frame
%             obj.tfs_{9} = hgtransform('Parent', obj.vizAx_);
%             
%             obj.frames_{9} = gencsframe(obj.vizAx_, 'D', scale, fontsize);
%             for j=1:numel(obj.frames_{9})
%                 set(obj.frames_{9}{j}, 'parent', obj.tfs_{9});
%             end
                
            %attach coordinate frames   
%             for i=2:NB
%                 obj.frames_{i} = gencsframe(obj.vizAx_, num2str(i-1), scale, fontsize);
%                 for j=1:numel(obj.frames_{i})
%                     set(obj.frames_{i}{j}, 'parent', obj.tfs_{i});
%                 end
%             end

          
            
            % Create rotorMax Vectors
%             for i=1:6
%                 obj.rotorMaxVecs_{i} = genomegavec(obj.vizAx_, 'omega', 12, 0.5, 0.1, 'black');
%                   set(obj.rotorMaxVecs_{i}{1}, 'parent', obj.tfs_{i+1});
%                   set(obj.rotorMaxVecs_{i}{1}, 'WData', scale);
%             end
            
%            tfidx = [1 1 2 2 3 3 4 4 5 5 6 6];
%             for i=1:12
%                 %uneven (top) rotors
%                 if mod(i,2) ~= 0
%                     obj.omegaVecs_{i} = genomegavec(obj.vizAx_, 'omega', 12, 2, 0.6, 'blue');
%                       set(obj.omegaVecs_{i}{1}, 'parent', obj.tfs_{tfidx(i)+1});
%                 else %even (bottom) rotors
%                     obj.omegaVecs_{i} = genomegavec(obj.vizAx_, 'omega', 12, 2, 0.6, 'red');
%                       set(obj.omegaVecs_{i}{1}, 'parent', obj.tfs_{tfidx(i)+1});
%                 end
%             end
              
            
            % Initialize Inertial frame
            obj.tfs_{8} = hgtransform('Parent', obj.vizAx_);
%             obj.frames_{8} = gencsframe(obj.vizAx_, 'I', scale, fontsize);
%             for j=1:numel(obj.frames_{8})
%               set(obj.frames_{8}{j}, 'parent', obj.tfs_{8});
%             end
            obj.Iorigin_ = Iorigin(:);
            TI = eye(4); TI(1:3,4) = obj.Iorigin_;
            set(obj.tfs_{8}, 'matrix', TI);
            
            % Initialize joint position
            obj.setJointPositions(zeros(6,1),zeros(3,1),eye(3,3),eye(3,3),zeros(12,1));
            

            

        end

        function [] = setJointPositions(obj, q, p, R, R_d, omegas)
            %R: Base orientation
            %q: tilt angles
            %p: base position in inertial frame

            if length(q)~=length(obj.rotAxis_)
                error('Wrong dimension of q, it should be length 6.');
            end
            
            if length(p)~= 3
                error('Wrong dimension of p, it should be length 3.');
            end
            
            if size(R) ~= [3,3]
                error('Wrong dimension of R, it should be 3x3');
            end
            
            if size(omegas) ~= 12
                error('Wrong dimension of omega, it should be 12');
            end

            % Initialize temporary body transform
            btf = eye(4);
%             for i=1:numel(obj.eePosVec_)
%                 delete (obj.eePosVec_{i});
%             end

            % Use succesive homogeneous-transformations to position each
            % body in the visualization
            
            %set base position and orientation
            btf = eye(4);
            btf(1:3,1:3) = R;
            p = p(:); %ensure that p is a column vector
            btf(1:3,4) = p;
            set(obj.tfs_{1},'matrix',btf);
            
            %set rotors position and orientation
            btf1 = btf*jointTf01(q);
            set(obj.tfs_{2}, 'matrix', btf1);
            btf2 = btf*jointTf02(q);
            set(obj.tfs_{3}, 'matrix', btf2);
            btf3 = btf*jointTf03(q);
            set(obj.tfs_{4}, 'matrix', btf3);
            btf4 = btf*jointTf04(q);
            set(obj.tfs_{5}, 'matrix', btf4);
            btf5 = btf*jointTf05(q);
            set(obj.tfs_{6}, 'matrix', btf5);
            btf6 = btf*jointTf06(q);
            set(obj.tfs_{7}, 'matrix', btf6);
            
            % set omegas
%             omega_scale = 1/1700;
%             for i=1:12
%                 omega = omegas(i);
%                 set(obj.omegaVecs_{i}{1}, 'WData', 0.2*omega*omega_scale);
%             end

            % set desired orientation
%             btf9 = eye(4);
%             btf9(1:3,1:3) = R_d;
%             btf9(1:3,4) = p;
%             set(obj.tfs_{9}, 'matrix', btf9);

            % Update figure/axes data
            drawnow;

        end

    end

end

%
% HELPER FUNCTIONS
%

function T01 = jointTf01(q)
  if (length(q)>1)
      alpha = q(1);
  end
  gamma = -pi/6 + 1*(pi/3);
  
  Tgamma = [cos(gamma), -sin(gamma), 0,     0.3*cos(gamma);
         sin(gamma),  cos(gamma), 0,     0.3*sin(gamma);
              0,       0, 1,     0;
              0,       0, 0,     1];
          
  Talpha = [1, 0, 0, 0;
            0, cos(alpha), -sin(alpha), 0;
            0, sin(alpha), cos(alpha), 0;
            0, 0, 0, 1];
        
  T01 = Tgamma*Talpha;
end

function T02 = jointTf02(q)
  if (length(q)>1)
      alpha = q(2);
  end
  gamma = -pi/6 + 2*(pi/3);
  
  Tgamma = [cos(gamma), -sin(gamma), 0,     0.3*cos(gamma);
         sin(gamma),  cos(gamma), 0,     0.3*sin(gamma);
              0,       0, 1,     0;
              0,       0, 0,     1];
          
  Talpha = [1, 0, 0, 0;
            0, cos(alpha), -sin(alpha), 0;
            0, sin(alpha), cos(alpha), 0;
            0, 0, 0, 1];
        
  T02 = Tgamma*Talpha;
end

function T03 = jointTf03(q)
  if (length(q)>1)
      alpha = q(3);
  end
  gamma = -pi/6 + 3*(pi/3);
  
  Tgamma = [cos(gamma), -sin(gamma), 0,     0.3*cos(gamma);
         sin(gamma),  cos(gamma), 0,     0.3*sin(gamma);
              0,       0, 1,     0;
              0,       0, 0,     1];
          
  Talpha = [1, 0, 0, 0;
            0, cos(alpha), -sin(alpha), 0;
            0, sin(alpha), cos(alpha), 0;
            0, 0, 0, 1];
        
  T03 = Tgamma*Talpha;
end

function T04 = jointTf04(q)
  if (length(q)>1)
      alpha = q(4);
  end
  gamma = -pi/6 + 4*(pi/3);
  
  Tgamma = [cos(gamma), -sin(gamma), 0,     0.3*cos(gamma);
         sin(gamma),  cos(gamma), 0,     0.3*sin(gamma);
              0,       0, 1,     0;
              0,       0, 0,     1];
          
  Talpha = [1, 0, 0, 0;
            0, cos(alpha), -sin(alpha), 0;
            0, sin(alpha), cos(alpha), 0;
            0, 0, 0, 1];
        
  T04 = Tgamma*Talpha;
end

function T05 = jointTf05(q)
  if (length(q)>1)
      alpha = q(5);
  end
  gamma = -pi/6 + 5*(pi/3);
  
  Tgamma = [cos(gamma), -sin(gamma), 0,     0.3*cos(gamma);
         sin(gamma),  cos(gamma), 0,     0.3*sin(gamma);
              0,       0, 1,     0;
              0,       0, 0,     1];
          
  Talpha = [1, 0, 0, 0;
            0, cos(alpha), -sin(alpha), 0;
            0, sin(alpha), cos(alpha), 0;
            0, 0, 0, 1];
        
  T05 = Tgamma*Talpha;
end

function T06 = jointTf06(q)
  if (length(q)>1)
      alpha = q(6);
  end
  gamma = -pi/6 + 6*(pi/3);
  
  Tgamma = [cos(gamma), -sin(gamma), 0,     0.3*cos(gamma);
         sin(gamma),  cos(gamma), 0,     0.3*sin(gamma);
              0,       0, 1,     0;
              0,       0, 0,     1];
          
  Talpha = [1, 0, 0, 0;
            0, cos(alpha), -sin(alpha), 0;
            0, sin(alpha), cos(alpha), 0;
            0, 0, 0, 1];
        
  T06 = Tgamma*Talpha;
end


