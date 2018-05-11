﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class sg_Special : MonoBehaviour {

    public int value;
    public sg_SpecialType type;
    private sg_SpecialType m_prevType;
    public Sprite healthSprite, damageSprite, shieldSprite;

    private SpriteRenderer m_renderer;

    public float rotateSpeed = 50f;
    public float despawnTime = 10f;
    private float m_despawnTimer = 0f;

    private Transform m_chiild;

    private sg_GameManager gm;

    private void Start()
    {
        gm = GameObject.Find("GM").GetComponent<sg_GameManager>();
        m_chiild = transform.GetChild(0).GetComponent<Transform>();
        m_renderer = m_chiild.GetComponent<SpriteRenderer>();
        SetImage();
    }

    private void OnEnable()
    {
        m_despawnTimer = 0f;
    }

    private void OnDisable()
    {
        m_despawnTimer = 0f;
    }

    private void SetImage()
    {
        switch (type)
        {
            case sg_SpecialType.Health:
                m_renderer.sprite = healthSprite;
                break;
            case sg_SpecialType.Damage:
                m_renderer.sprite = damageSprite;
                break;
            case sg_SpecialType.Shield:
                m_renderer.sprite = shieldSprite;
                break;
            default:
                break;
        }

        m_prevType = type;
    }

    private void Update()
    {
        m_chiild.Rotate(Vector3.up * rotateSpeed * Time.deltaTime);

        if (m_prevType != type) SetImage();

        m_despawnTimer += Time.deltaTime;
        if(m_despawnTimer >= despawnTime)
        {
            gm.DespawnSpecial(this.gameObject);
            m_despawnTimer = 0f;
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        sg_ShipAi ship = other.gameObject.GetComponent<sg_ShipAi>();
        if (ship != null && other.gameObject.CompareTag("Player"))
        {
            switch (type)
            {
                case sg_SpecialType.Health:
                    ship.data.health = Mathf.Clamp(ship.data.health + value, 0, ship.data.maxHealth);
                    Debug.Log("Applied " + value + " health to '" + ship.data.name + "'");
                    break;
                case sg_SpecialType.Damage:
                    break;
                case sg_SpecialType.Shield:
                    break;
                default:
                    break;
            }

            gm.DespawnSpecial(this.gameObject);
        }
    }
}

public enum sg_SpecialType
{
    Health, Damage, Shield
}