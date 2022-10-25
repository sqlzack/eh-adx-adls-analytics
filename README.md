# Streaming to Partitioned Parquet Files with Azure Data Explorer

## Summary
This project is meant to demonstrate how Azure Data Explorer (ADX) can be used to continuously ingest a Azure Event Hubs stream to a raw table, a cleaned table, and finally to partitioned Parquet files on Azure Data Lake Storage. The idea behind this concept is this will give you a hot path in the ADX clean table and a cool path (and archive!) in the partitioned Parquet files.

## Simplified Architecture
![picture of base architecture](/images/base_arch.png)
1) VM running a dockerized Python script that pushes 175 million 2013 NYC Taxi Fare records to Azure Event Hubs
2) ADX ingests event hub data at a configurable interval.
3) ADX sends data to Parquet files on storage through the mechanism of Continuous Export to a partitioned External Table in Parquet format.

## Pre-requisites 
_WIP: Will attempt to add ARM/Bicep scripts for resources eventually_
1) VM to host Python Streaming App 
2) Event Hub to receive data from Python Steraming App
3) Azure Data Explorer Cluster _(Can be provisioned in Azure Synapse workspace)_
4) Storage Account - Azure Data Lake Gen 2 with Hierarchical Namespace Enabled 

## Steps to Create
1) Set up pre-requisites (link coming soon)