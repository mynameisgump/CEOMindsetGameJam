import React, { useRef, useState, useMemo } from 'react'
import { Canvas, useFrame } from '@react-three/fiber'
import { OrbitControls, Gltf } from '@react-three/drei'
import { CollideEvent, Physics, useBox, usePlane, Debug, useSphere } from '@react-three/cannon'
import { Instances, Stats} from '@react-three/drei'




const Plane = () => {
  const [ref] = usePlane(() => ({ rotation: [-Math.PI / 2, 0, 0] }))
  return (
    <mesh name="Plane" receiveShadow ref={ref}>
      <planeGeometry />
      <meshStandardMaterial color="#f0f0f0" />
    </mesh>
  )
}

type CubeProps = {
  position: [x: number, y: number, z: number]
}
const Cube = ({position}: CubeProps) => {

  const collisionEvent = (e: CollideEvent) => {
    console.log("collision");
    console.log(e);
  }

  const [ref] = useSphere(() => ({ mass: 1, onCollide: collisionEvent, position: position }))
  return (
    <Gltf src="/public/MansonFish.glb" ref={ref}></Gltf>
    // <mesh name="Cube" castShadow ref={ref}>
      
    //   <boxGeometry />
    //   <meshStandardMaterial color="orange" />
    // </mesh>
  )
}

const Sphere = ({position}: CubeProps) => {

  const collisionEvent = (e: CollideEvent) => {
    console.log("collision");
    console.log(e);
  }

  const [ref] = useSphere(() => ({ mass: 1, onCollide: collisionEvent, position: position }))
  return (
    <mesh ref={ref}>
      <sphereGeometry  args={[1, 32, 32]} />
      <meshBasicMaterial color="orange" />
    </mesh>

  )
}

const Grinder = () => {
  // const [ref] = useBox(() => ({ mass: 1, position: [0, 0, 0] }))
  return (
    <Gltf src="/public/Grinder_Sep.glb" castShadow >

    </Gltf>
  )
}


const ThreeApp = () => {
 return (
    <div style={{width: "100vw", height: "100vh"}}>
        <Canvas>
            <Stats showPanel={0} className="stats"  />
            <ambientLight />
            <pointLight position={[10, 10, 10]} />

            <OrbitControls />
            <Physics>
              <Debug scale={1.1} color="black">
              <Sphere position={[0, 30, 0]} />
              <Plane></Plane>
              </Debug>
              <Grinder></Grinder>
            </Physics>
        </Canvas>
    </div>
 )
}
  
export default ThreeApp;
