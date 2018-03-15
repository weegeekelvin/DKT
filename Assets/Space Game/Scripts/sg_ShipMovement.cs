﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class sg_ShipMovement : MonoBehaviour {

    public float thrusterForce = 10f;
    public float turningSpeed = 10f;
    public float tollerance = 0f;
    public Transform target;
    private Transform m_transform;
    private Rigidbody m_rb;
    [SerializeField]
    private float m_distanceFromTarget;
    public AnimationCurve decelerationRamp;     //  The curve the ship uses to control it's deceleration.
    public float decelerationDistance;          //  How close the ship must be from the target before it decelerates.
    [SerializeField]
    private float applyForce = 0f;
    [SerializeField]
    private Vector3 directionToTarget;

    private void Start()
    {
        m_rb = GetComponent<Rigidbody>();
        m_transform = GetComponent<Transform>();
    }

    private void Update()
    {
        m_distanceFromTarget = Vector3.Distance(m_transform.position, target.position);
        directionToTarget = Vector3.Normalize(target.position - m_transform.position);
        if(m_distanceFromTarget >= tollerance)
        {
            Move();
        }
    }

    private void Move()
    {
        if(m_distanceFromTarget <= decelerationDistance)
        {
            //  Decelerate
            applyForce = thrusterForce * (decelerationRamp.Evaluate(m_distanceFromTarget / decelerationDistance));
        }
        else
        {
            applyForce = thrusterForce;
        }
        m_rb.AddForce(directionToTarget * applyForce * Time.deltaTime, ForceMode.Impulse);
    }
}
