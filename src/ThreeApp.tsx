import React, { useRef, useState, useMemo } from 'react'
import { Canvas, useFrame } from '@react-three/fiber'
import { OrbitControls, Gltf } from '@react-three/drei'
import { Instances, Stats, Environment} from '@react-three/drei'
import { Physics, RigidBody } from '@react-three/rapier'
import { Box } from '@react-three/drei'


const Floor = () => {
  console.log("floor test")
  return (
    <RigidBody type="fixed" colliders="cuboid" name="floor">
      <Box
        position={[0, -12.55 - 5, 0]}
        scale={[200, 10, 200]}
        rotation={[0, 0, 0]}
        receiveShadow
      >
        <meshStandardMaterial color={"red"}/>
      </Box>
    </RigidBody>
  );
};


// const Manson = (props: GroupProps) => {
//   const { nodes } = useGLTF(
//     new URL("../../models/objects.glb", import.meta.url).toString()
//   ) as unknown as {
//     nodes: {
//       pear: Mesh;
//     };
//   };

//   return (
//     <group {...props} scale={1}>
//       <RigidBody position={[0, 2, 0]} colliders="hull">
//         <Clone object={nodes.pear} castShadow receiveShadow />
//       </RigidBody>
//     </group>
//   );
// };

const Meat = () => {
  return (
    <RigidBody>
      <mesh position={[0,5,0]} castShadow={true}>
        <sphereGeometry args={[1, 32, 32]} />
        <meshStandardMaterial color="hotpink" />
      </mesh>
    </RigidBody>
  )
}

const Grinder = () => {
  return (
    <RigidBody colliders={"hull"} type={"fixed"}>
      <Gltf src="/public/Grinder_Sep.glb" castShadow >
      </Gltf>
    </RigidBody>

  )
}


const ThreeApp = () => {
 return (
    <div style={{width: "100vw", height: "100vh"}}>
        <Canvas shadows dpr={1}>
            <Stats showPanel={0} className="stats"  />
            {/* <ambientLight /> */}
            <pointLight position={[10, 10, 10]} />

            <OrbitControls />

            <directionalLight
                castShadow
                position={[10, 10, 10]}
                shadow-camera-bottom={-40}
                shadow-camera-top={40}
                shadow-camera-left={-40}
                shadow-camera-right={40}
                shadow-mapSize-width={1024}
                shadow-bias={-0.0001}
              />
            <Environment preset="apartment" />

            <Physics debug gravity={[0, -1, 0]} >
              <Meat></Meat>
              <Floor></Floor>
              <Grinder></Grinder>
            </Physics>
            
        </Canvas>
    </div>
 )
}
  
export default ThreeApp;
