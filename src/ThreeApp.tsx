import React, { useRef, useState, useEffect, useMemo } from 'react'
import { Canvas } from '@react-three/fiber'
import { OrbitControls } from '@react-three/drei'
import { Stats, Environment} from '@react-three/drei'
import { Physics, RigidBody, InstancedRigidBodies, InstancedRigidBodiesProps} from '@react-three/rapier'
import { Box } from '@react-three/drei'
import GrinderSep from './GrinderSep'
import { BoxGeometry, Color, Mesh, MeshBasicMaterial, MeshLambertMaterial } from 'three'





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


const Meat = () => {
  
  return (
    <RigidBody colliders="hull" name="Meat">
      <mesh position={[0,5,0]} castShadow={true}>
        <sphereGeometry args={[1, 32, 32]} />
        <meshStandardMaterial color="hotpink" />
      </mesh>
    </RigidBody>
  )
}

const createBody = (): InstancedRigidBodyProps => ({
  key: Math.random(),
  position: [Math.random() * 20, Math.random() * 20, Math.random() * 20],
  rotation: [
    Math.random() * Math.PI * 2,
    Math.random() * Math.PI * 2,
    Math.random() * Math.PI * 2
  ],
  scale: [0.5 + Math.random(), 0.5 + Math.random(), 0.5 + Math.random()]
});

const COUNT = 100;
const ThreeApp = () => {
  const instances = useMemo(() => {
    const instances: InstancedRigidBodyProps[] = [];

    for (let i = 0; i < COUNT; i++) {
      instances.push({
        key: "instance_" + Math.random(),
        position: [Math.random() * 10, Math.random() * 10, Math.random() * 10],
        rotation: [Math.random(), Math.random(), Math.random()]
      });
    }

    return instances;
  }, []);

 return (
    <div style={{width: "100vw", height: "100vh"}}>
        <Canvas shadows dpr={1}>
            <Stats showPanel={0} className="stats"  />
            {/* <ambientLight /> */}
            <pointLight position={[10, 10, 10]} />

            <OrbitControls />

            <Environment preset="apartment" />

            <Physics debug gravity={[0, -1, 0]} >
              {/* <Meat></Meat> */}
              <Floor></Floor>
              <GrinderSep></GrinderSep>
              <InstancedRigidBodies
                instances={instances}
                colliders="ball"
                // colliderNodes={[
                //   <BoxCollider args={[0.5, 0.5, 0.5]} />,
                //   <SphereCollider args={[0.5]} />
                // ]}
              >
                  <instancedMesh args={[undefined, undefined, COUNT]} count={COUNT} >
                    <sphereGeometry args={[1, 32, 32]} />
                    <meshStandardMaterial color="hotpink" />
                  </instancedMesh>
              </InstancedRigidBodies>
            </Physics>
            
        </Canvas>
    </div>
 )
}
  
export default ThreeApp;
