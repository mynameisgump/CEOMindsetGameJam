import { RigidBody } from "@react-three/rapier";
import { useGLTF } from "@react-three/drei";

const GrinderSep = () => {
    const { nodes, materials } = useGLTF("/Grinder_Sep_2x.glb");
    return (
      <group scale={[2,2,2]} dispose={null}>
        <RigidBody name="Grinder" colliders={"hull"} type={"fixed"}
        onCollisionEnter={({ target, other }) => {
            // console.log(
            //   "Collision at world position ",
            //   manifold.solverContactPoint(0)
            // );
    
            if (other.rigidBodyObject) {
              console.log(
                // this rigid body's Object3D
                target,
                " collided with ",
                // the other rigid body's Object3D
                other
              );
            }
          }}
          >
            <mesh
            name="Cube"
            castShadow
            receiveShadow
            geometry={nodes.Cube.geometry}
            material={materials["Material.001"]}
            scale={[1, 0.276, 1]}
            />
        </RigidBody>
        <RigidBody colliders={"hull"} type={"fixed"}>
            <mesh
                name="Slide3"
                castShadow
                receiveShadow
                geometry={nodes.Slide3.geometry}
                material={materials["Material.002"]}
                position={[-2.979, 4.389, 2.988]}
                rotation={[0, 0, -0.803]}
                scale={[4.298, 0.276, 1]}
            />
            <mesh
                name="Slide2"
                castShadow
                receiveShadow
                geometry={nodes.Slide2.geometry}
                material={materials["Material.002"]}
                position={[-2.983, 4.389, -2.972]}
                rotation={[0, 0, -0.803]}
                scale={[4.298, 0.276, 1]}
            />
            <mesh
                name="Slide1"
                castShadow
                receiveShadow
                geometry={nodes.Slide1.geometry}
                material={materials["Material.002"]}
                position={[2.988, 4.389, -2.972]}
                rotation={[0, 0, -0.803]}
                scale={[4.298, 0.276, 1]}
            />
            <mesh
                name="Slide4"
                castShadow
                receiveShadow
                geometry={nodes.Slide4.geometry}
                material={materials["Material.002"]}
                position={[2.988, 4.389, 2.984]}
                rotation={[0, 0, -0.803]}
                scale={[4.298, 0.276, 1]}
            />
            <mesh
                name="Square1"
                castShadow
                receiveShadow
                geometry={nodes.Square1.geometry}
                material={materials["Material.002"]}
                position={[-0.005, 3.166, -4.152]}
                rotation={[0, 0, -0.803]}
                scale={[4.298, 0.276, 1]}
            />
            <mesh
                name="Square2"
                castShadow
                receiveShadow
                geometry={nodes.Square2.geometry}
                material={materials["Material.002"]}
                position={[4.186, 3.166, 0.001]}
                rotation={[0, 0, -0.803]}
                scale={[4.298, 0.276, 1]}
            />
            <mesh
                name="Square3"
                castShadow
                receiveShadow
                geometry={nodes.Square3.geometry}
                material={materials["Material.002"]}
                position={[-4.164, 3.167, 0.003]}
                rotation={[0, 0, -0.803]}
                scale={[4.298, 0.276, 1]}
            />
            <mesh
                name="Square4"
                castShadow
                receiveShadow
                geometry={nodes.Square4.geometry}
                material={materials["Material.002"]}
                position={[-0.004, 3.167, 4.175]}
                rotation={[0, 0, -0.803]}
                scale={[4.298, 0.276, 1]}
            />
        </RigidBody>

      </group>
    );
  }
  
  useGLTF.preload("/Grinder_Sep.glb");

  export default GrinderSep;