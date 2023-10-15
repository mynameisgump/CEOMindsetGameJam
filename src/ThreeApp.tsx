import React, { useRef, useState, useEffect, useMemo, useCallback } from 'react'
import { Canvas } from '@react-three/fiber'
import { OrbitControls } from '@react-three/drei'
import { Stats, Environment} from '@react-three/drei'
import { Physics, RigidBody, InstancedRigidBodies, InstancedRigidBodyProps, InstancedRigidBodiesProps, RapierRigidBody, CollisionEnterPayload} from '@react-three/rapier'
import { Box } from '@react-three/drei'
import GrinderSep from './GrinderSep'
import { BoxGeometry, Color, Mesh, MeshBasicMaterial, MeshLambertMaterial } from 'three'
import { useThree } from '@react-three/fiber'





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

const COUNT = 2;

const createBody = (): InstancedRigidBodyProps => ({
  key: Math.random(),
  instanceId: Math.random().toString(),
  position: [Math.random() * 20, Math.random() * 20, Math.random() * 20],
  rotation: [
    Math.random() * Math.PI * 2,
    Math.random() * Math.PI * 2,
    Math.random() * Math.PI * 2
  ],
});


const InstancedScene = () => {
  const { scene } = useThree();

  const [bodies, setBodies] = useState<InstancedRigidBodyProps[]>(() =>
    Array.from({
      length: COUNT
    }).map(() => createBody())
  );


  const api = useRef<RapierRigidBody[]>([]);


  useEffect(() => {
    if (api) {
      console.log("api", api)
    }
  },[api])


  const removeInstance = (e: CollisionEnterPayload) => {
    const instanceId = e.target.rigidBodyObject.instanceId;
    const instanceIndex = bodies.findIndex((body) => body.instanceId === instanceId);
    const clonedBodies = [...bodies]
    clonedBodies.pop(instanceIndex);
    setBodies(clonedBodies)
    
  };

  return (
    <InstancedRigidBodies
      instances={bodies}
      colliders="ball"
      onCollisionEnter={(e) => {
        //Gump Cry
        console.log("Collision Key?", e.target)
        removeInstance(e)
      }}
      ref={api}
    >
        <instancedMesh args={[undefined, undefined, COUNT]} count={bodies.length} >
          <sphereGeometry args={[1, 32, 32]} />
          <meshStandardMaterial color="hotpink" />
        </instancedMesh>
    </InstancedRigidBodies>
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

            <Environment preset="apartment" />

            <Physics debug gravity={[0, -1, 0]} >
              {/* <Meat></Meat> */}
              <Floor></Floor>
              <GrinderSep></GrinderSep>
              <InstancedScene></InstancedScene>
            </Physics>
            
        </Canvas>
    </div>
 )
}
  
export default ThreeApp;
